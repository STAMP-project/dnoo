package  fr.inria.stamp.examples.dnoo.dnooMain;

import static org.junit.Assert.assertEquals;
import org.junit.Test;
import java.io.File;

import fr.inria.stamp.examples.dnoo.dnooHello.HelloApp;
import fr.inria.stamp.examples.dnoo.dnooStorage.MyStorage;
import fr.inria.stamp.examples.dnoo.dnooLogs.MyLogger;

public class GlobalAppTest
{
   // **********************************************************************
   // public
   // **********************************************************************
   @Test
   public void testGlobalAppRun1() throws Exception
   {
      HelloApp myApp = null;
      File theFile = null;
      MyStorage fileContent = null;
      int myCount = 11;
      String countString = Integer.toString(myCount);
      String helloString = "----------- Hello World !";
      String myTracesName = "global1.traces";

      MyLogger.clearLogs();

      myApp = new HelloApp(myCount, myTracesName);
      myApp.run();

      fileContent = new MyStorage(myApp.getMyTracesName());
      fileContent.readData();
      assertEquals(true, fileContent.isEqual(myApp.getMyTraces()));
      assertEquals(true, countString.equals(fileContent.getData(0)));
      assertEquals(true, helloString.equals(fileContent.getData(2)));
   }

   // **********************************************************************
   @Test
   public void testGlobalAppRun2() throws Exception
   {
      HelloApp myApp = null;
      File theFile = null;
      MyStorage fileContent = null;
      int myCount = 8;
      String countString = Integer.toString(myCount);
      String helloString = "-------- Hello World !";
      String myTracesName = "global2.traces";

      MyLogger.clearLogs();

      myApp = new HelloApp(myCount, myTracesName);
      myApp.run();

      fileContent = new MyStorage(myApp.getMyTracesName());
      fileContent.readData();
      assertEquals(true, fileContent.isEqual(myApp.getMyTraces()));
      assertEquals(true, countString.equals(fileContent.getData(0)));
      assertEquals(true, helloString.equals(fileContent.getData(2)));
   }
}
