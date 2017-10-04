package fr.inria.stamp.examples.dnoo.dnooLogs;

import static org.junit.Assert.assertEquals;
import org.junit.Test;
import java.io.File;
import java.util.*;

import fr.inria.stamp.examples.dnoo.dnooLogs.MyLogger;

public class MyLoggerTest
{
   // **********************************************************************
   // public
   // **********************************************************************
   @Test
   public void testMyLoggerDefault() throws Exception
   {
      System.out.println("******** testMyLoggerDefault");

      MyLogger.getLogger().info("testMyLoggerDefault");
      assertEquals(MyLogger.getLevel(), "WARNING");
   }

   // **********************************************************************
   @Test
   public void testMyLoggerSetLevel1() throws Exception
   {
      System.out.println("******** testMyLoggerSetLevel1");
      MyLogger.setLevel("FINE");

      MyLogger.getLogger().info("testMyLoggerSetLevel1: FINE");
      assertEquals(MyLogger.getLevel(), "FINE");
   }

   // **********************************************************************
   @Test
   public void testMyLoggerSetLevel2() throws Exception
   {
      System.out.println("******** testMyLoggerSetLevel2");
      MyLogger.setLevel("ALL");

      MyLogger.getLogger().info("testMyLoggerSetLevel2: ALL");
      assertEquals(MyLogger.getLevel(), "ALL");
   }

}
