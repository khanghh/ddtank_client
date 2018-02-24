package treasure.view
{
   import com.pickgliss.manager.CacheSysManager;
   import ddt.manager.ChatManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   
   public class TreasureMain extends BaseStateView
   {
       
      
      private var _treasure:TreasureView;
      
      public function TreasureMain(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function dispose() : void{}
   }
}
