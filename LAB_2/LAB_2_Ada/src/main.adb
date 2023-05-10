with ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Main is

	threads_count: Integer := 4;
	arr_length: Integer := 200000;
	arr: array(1..arr_length) of Integer;

	function generate_random_number(minimum, maximum : Integer) return Integer is
		type number_range is new Integer range minimum..maximum;
		package Rand_Int is new ada.numerics.Discrete_Random(number_range);
		use Rand_Int;
		gen: Generator;
		num: number_range;
	begin
		reset(gen);
		num := random(gen);
		return Integer(num);
	end generate_random_number;


	procedure initialize_array is
	begin
		for i in 1..arr_length loop
			arr(i) := generate_random_number(1, 500000);
		end loop;

		arr(generate_random_number(1, arr_length)) := -100000;
	end initialize_array;

	-- Protected Object
	protected part_manager is
		procedure set_find_min(min: in Integer);
		entry get_index_min_number(min: out Integer);
	private
		task_count: Integer:= 0;
		current_min: Integer := arr(1);
		current_min_index: Integer := 1;
	end part_manager;

	protected body part_manager is
		procedure set_find_min (min: in Integer) is
		begin
			if(current_min > arr(min)) then
				current_min := arr(min);
				current_min_index := min;
			end if;
			task_count := task_count + 1;
		end set_find_min;

		entry get_index_min_number(min: out Integer) when task_count = threads_count is
		begin
			min := current_min_index;
		end get_index_min_number;
	end part_manager;
	-- End Object

	function find_min_index(start_index, end_index : in Integer) return Integer is
		min: Integer := arr(arr_length);
		min_index: Integer;
	begin
		for i in start_index..end_index loop
			if(min > arr(i)) then
				min := arr(i);
				min_index := i;
			end if;
		end loop;
		return min_index;
	end find_min_index;

	task type find_min_element_index_task is
		entry start(from_index, to_index : in Integer);
	end find_min_element_index_task;

	task body find_min_element_index_task is
		min_index: Integer;
		start_index, end_index : Integer;
	begin
		accept start (from_index, to_index : in Integer) do
			find_min_element_index_task.start_index := from_index;
			find_min_element_index_task.end_index := to_index;
			find_min_element_index_task.min_index := from_index;
		end start;
		min_index := find_min_index(start_index => start_index, end_index => end_index);
		part_manager.set_find_min(min_index);
	end find_min_element_index_task;


	function parallel_min return Integer is
		min_number_index: Integer := 0;
		segment_lenth: Integer := arr_length / threads_count;
		start_index: Integer;
		end_index: Integer;
		thread : array(1..threads_count) of find_min_element_index_task;
	begin
		for i in 1..threads_count loop
			if(i = 1) then
				start_index := segment_lenth * (i-1)+1;
			else
				start_index := segment_lenth * (i-1);
			end if;

			if(i = (threads_count - 1)) then
				end_index := arr_length;
			else
				end_index := segment_lenth * i;
			end if;

			thread(i).start(start_index, end_index);
		end loop;
		part_manager.get_index_min_number(min_number_index);
		return min_number_index;
	end parallel_min;

	result: Integer;
begin
	initialize_array;
	result:= parallel_min;
	Put_Line(arr(result)'img);
	Put_Line(result'img);
end Main;
