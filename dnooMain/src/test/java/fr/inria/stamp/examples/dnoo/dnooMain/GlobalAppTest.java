package  fr.inria.stamp.examples.dnoo.dnooMain;

import static org.junit.Assert.assertEquals;
import org.junit.Test;
import java.io.File;

import fr.inria.stamp.examples.dnoo.dnooHello.HelloApp;
import fr.inria.stamp.examples.dnoo.dnooStorage.MyStorage;

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
      String MyTracesName = "global1.traces";
      // String message;

      myApp = new HelloApp(myCount, MyTracesName);
      myApp.run();

      // message = "#### TracesName = " + myApp.getMyTracesName();
      // System.out.println(message);

      fileContent = new MyStorage(myApp.getMyTracesName());
      fileContent.readData();
      assertEquals(true, fileContent.isEqual(myApp.getMyTraces()));
      assertEquals(true, countString.equals(fileContent.getData(0)));
      assertEquals(true, helloString.equals(fileContent.getData(2)));
   }

   // **********************************************************************
   // private
   // **********************************************************************
   // ******** attributes
}
