# AUDVisualizer

![Swift](https://img.shields.io/badge/-Swift-FA7343?style=flat-square&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/-SwiftUI-black?style=flat-square&logo=swift&logoColor=white)
![MVVM](https://img.shields.io/badge/-MVVM-blue?style=flat-square)


AUDVisualizer is an interactive SwiftUI app that follows the MVVM design pattern. With it, you can visualize different sorting algorithms using animated bar charts. Control the sorting speed, follow along with step-by-step mode, and compare algorithms for an exciting and interactive learning experience.

## Features

- **Visualizations:** Visualize sorting algorithms with colored bar charts.
- **Multiple Algorithms:** Implementations for Bubble Sort, Insertion Sort, Merge Sort, Quick Sort, and Radix Sort.
- **Step-by-Step Mode:** Walk through the algorithms step-by-step with explanations for each move.
- **Customizable Input:** Input your own numbers or generate random ones to sort.
- **Built with Swift & SwiftUI:** Utilizes the latest SwiftUI framework with MVVM design pattern.

## Algorithms

The following sorting algorithms are included:

1. **Bubble Sort:** A simple comparison-based sort that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.
2. **Insertion Sort:** Builds a sorted array one element at a time by repeatedly removing unsorted elements and inserting them into the correct position in the sorted part.
3. **Merge Sort:** Divides the unsorted list into n sublists, each containing one element, and then repeatedly merges sublists to produce new sorted sublists until there is only one left.
4. **Quick Sort:** Uses a divide-and-conquer strategy to sort. Selects a 'pivot' element and partitions the other values into two sub-arrays, according to whether they are less than or greater than the pivot.
5. **Radix Sort:** Non-comparative integer sorting algorithm that sorts numbers by processing individual digits.

## Architecture

The project is built using the Model-View-ViewModel (MVVM) pattern. The main classes are:
- **SortingAlgorithm:** A protocol that defines the sorting algorithms.
- **SortVisualizerView:** SwiftUI view that visualizes the numbers as bars.
- **ContentView:** SwiftUI view that contains the UI components.
- **SortViewModel:** ViewModel that handles the business logic.

## How to Use

- Choose an Algorithm: Select one of the available sorting algorithms.
- Input Numbers: Enter numbers separated by a comma or generate random numbers.
- Start Sorting: Click the "Start algorithm" button to visualize the sorting.
- Step-by-Step Mode: Enable the step-by-step mode to navigate through the sorting steps.

## Installation

- Clone this repository.
- Open the project in Xcode.
- Build and run the project on a simulator or physical device.

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to check [issues page](https://github.com/1xxn/AUDVisualizer/issues).

## License

This project is MIT licensed.

Feel free to get in touch if you have any questions or need further assistance.
