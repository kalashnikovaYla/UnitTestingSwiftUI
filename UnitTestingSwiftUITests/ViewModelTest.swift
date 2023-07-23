//
//  ViewModelTest.swift
//  UnitTestingSwiftUITests
//
//  Created by sss on 23.07.2023.
//

import XCTest
@testable import UnitTestingSwiftUI

//Naming structure: test_[struct or class]_[variable or function]_[expected result]
//Testing structure: Given, When, Then
//Зачем? чтобы убедится что код, который есть сейчас всегда будет работать и в будущем

final class ViewModelTest: XCTestCase {

    
    func test_ViewModel_isPremium_shouldBeTrue() {
        //Given
        let userIsPremium: Bool = true
        
        //When
        let vm = ViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_ViewModel_isPremium_shouldBeFalse() {
        //Given
        let userIsPremium: Bool = false
        
        //When
        let vm = ViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_ViewModel_isPremium_shouldBeInjectiveValue() {
        //Given
        let userIsPremium: Bool = Bool.random()
        
        //When
        let vm = ViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertEqual(userIsPremium, vm.isPremium )
    }
    
    func test_ViewModel_isPremium_shouldBeInjectiveValue_stress() {
        for _ in 0...10 {
            //Given
            let userIsPremium: Bool = Bool.random()
            
            //When
            let vm = ViewModel(isPremium: userIsPremium)
            
            //Then
            XCTAssertEqual(userIsPremium, vm.isPremium )
        }
    }
    
    func test_ViewModel_dataArray_shouldBeEmpty() {
        //Given
        
        //When
        let vm = ViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_ViewModel_dataArray_shouldAddItems() {
        //Given
        let vm = ViewModel(isPremium: Bool.random())
        
        //When
        let loopCount: Int = Int.random(in: 0...100)
        for _ in 0 ..< loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        
    }
    
    func test_ViewModel_dataArray_shouldNotAddBlanksString() {
        //Given
        let vm = ViewModel(isPremium: Bool.random())
        
        //When
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    
    func test_ViewModel_dataArray_shouldStartAsNil() {
        //Given
                
        //When
        let vm = ViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.selectedItem == nil)
    }
    
    func test_ViewModel_dataArray_shouldBeNillWhenSelectingInvalidItem() {
        //Given
        let vm = ViewModel(isPremium: Bool.random())
        
        //When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        vm.selectItem(item: UUID().uuidString)
        
        //Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_ViewModel_dataArray_shouldBeNillWhenSelected() {
        //Given
        let vm = ViewModel(isPremium: Bool.random())
        
        //When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_ViewModel_dataArray_shouldBeNillWhenSelected_stress() {
        //Given
        let vm = ViewModel(isPremium: Bool.random())
        
        //When
        let loopCount = Int.random(in: 1...100)
        var array: [String] = []
        
        for _ in 0 ... loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            array.append(newItem)
        }
    
        let randomElement = array.randomElement() ?? ""
        vm.selectItem(item: randomElement)
        
        //Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomElement)
    }
    
    func test_ViewModel_saveItem_shouldThrowError_itemNotFound() {
        //Given
        let vm = ViewModel(isPremium: Bool.random())
        
        //When
        let loopCount = Int.random(in: 1...100)
        
        for _ in 0 ... loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
        }
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw Item not found error") { error in
            let returnedError = error as? DataError
            XCTAssertEqual(returnedError, DataError.itemNotFound)
        }
    }
    
    func test_ViewModel_saveItem_shouldThrowError_noData() {
        //Given
        let vm = ViewModel(isPremium: Bool.random())
        
        //When
        let loopCount = Int.random(in: 1...100)
        
        for _ in 0 ... loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
        }
        
        //Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? DataError
            XCTAssertEqual(returnedError, DataError.noData)
        }
    }
}
