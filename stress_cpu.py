import time
import multiprocessing


def fibonacci(n):
    """Рекурсивное вычисление числа Фибоначчи."""
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)


def cpu_intensive_task():
    """Функция, создающая нагрузку на CPU."""
    start_time = time.time()

    while True:
        fibonacci(35)

        current_time = time.time()
        if current_time - start_time > 10:
            print(f"[{time.strftime('%H:%M:%S')}] Still working...", flush=True)
            start_time = current_time


if __name__ == "__main__":
    print(f"[{time.strftime('%H:%M:%S')}] Starting CPU stress test...", flush=True)

    num_processes = 2
    processes = []

    for _ in range(num_processes):
        p = multiprocessing.Process(target=cpu_intensive_task)
        p.start()
        processes.append(p)

    for p in processes:
        p.join()