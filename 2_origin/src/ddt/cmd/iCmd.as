package ddt.cmd
{
   import com.pickgliss.ui.core.Disposeable;
   
   public interface iCmd extends Disposeable
   {
       
      
      function excute(param1:Object) : *;
   }
}
