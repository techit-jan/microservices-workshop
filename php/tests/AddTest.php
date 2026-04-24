<?php

use PHPUnit\Framework\TestCase;

require_once __DIR__ . "/../test_function.php";

final class AddTest extends TestCase
{
    public function testAddSuccess(): void
    {
        $this->assertSame(3, add(1, 2));
        $this->assertSame(0, add(-1, 1));
        $this->assertSame(0, add(0, 0));
    }

    public function testAddFailCase(): void
    {
        $this->assertNotSame(-1, add(1, 2));
    }

    public function testBadAddShouldFail(): void
    {
        $this->assertSame(3, bad_add(1, 2));
    }
}