package com.example.helloworld;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Disabled;

import static org.junit.jupiter.api.Assertions.*;

class UnitTests {

    @Test
    void testAddSuccess() {
        assertEquals(3, TestFunction.add(1, 2));
        assertEquals(0, TestFunction.add(-1, 1));
        assertEquals(0, TestFunction.add(0, 0));
    }

    @Test
    void testAddFailCase() {
        assertNotEquals(-1, TestFunction.add(1, 2));
    }

    @Disabled("intentional fail")
    @Test
    void testBadAddFail() {
        assertEquals(3, TestFunction.badAdd(1, 2)); // อันนี้ตั้งใจให้ FAIL
    }

    @Test
    void testBadAddSuccess() {
        assertNotEquals(3, TestFunction.badAdd(1, 2)); // อันนี้ PASS
    }
}