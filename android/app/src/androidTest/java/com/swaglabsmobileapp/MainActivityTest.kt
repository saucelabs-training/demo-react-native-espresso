package com.swaglabsmobileapp

import android.support.test.espresso.Espresso
import android.support.test.espresso.Espresso.onView
import android.support.test.espresso.action.ViewActions.*
import android.support.test.espresso.assertion.ViewAssertions.matches
import android.support.test.espresso.matcher.ViewMatchers.*
import android.support.test.rule.ActivityTestRule
import android.support.test.runner.AndroidJUnit4
import org.hamcrest.CoreMatchers.allOf
import org.hamcrest.CoreMatchers.not
import org.junit.Test

import org.junit.Rule
import org.junit.runner.RunWith


@RunWith(AndroidJUnit4::class)
class MainActivityTest  {
    @Rule @JvmField
    var activityRule = ActivityTestRule<MainActivity>(MainActivity::class.java)

    @Test
    fun successfulLogin() {
        try {
            Thread.sleep(1500)
        } catch (e: InterruptedException) {
            e.printStackTrace()
        }

        // Finds the Username element
        onView(allOf(withContentDescription("test-Username"), isDisplayed()))
                .check(matches(withText("")))
                .perform(typeText("standard_user"))


        // Finds the Password element
        onView(allOf(withContentDescription("test-Password"), isDisplayed()))
                .check(matches(withText("")))
                .perform(typeText("secret_sauce"))
        Espresso.closeSoftKeyboard()

        // Finds the Login Button
        onView(allOf(withContentDescription("test-LOGIN"), isDisplayed()))
                .check(matches(not(isClickable())))
                .perform(click())

        // Finds the Products page
        onView(allOf(withContentDescription("test-PRODUCTS"), isDisplayed()))

    }
}