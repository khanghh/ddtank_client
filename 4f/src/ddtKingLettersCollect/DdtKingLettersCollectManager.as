package ddtKingLettersCollect
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.IHallStateView;
   import nationDay.NationDayManager;
   import road7th.comm.PackageIn;
   
   public class DdtKingLettersCollectManager extends CoreManager
   {
      
      public static const SHOW:String = "dklc_show";
      
      public static const UPDATE:String = "dklc_update";
      
      public static const ComposedItemTempleteID:int = 1120370;
      
      private static var instance:DdtKingLettersCollectManager;
       
      
      private var _hall:IHallStateView;
      
      private var _icon:MovieClip;
      
      private var _isOpen:Boolean = false;
      
      public var WordArray:Dictionary;
      
      public function DdtKingLettersCollectManager(param1:inner){super();}
      
      public static function getInstance() : DdtKingLettersCollectManager{return null;}
      
      public function setup() : void{}
      
      protected function __onGetHideTitleFlag(param1:PkgEvent) : void{}
      
      public function showIcon(param1:IHallStateView) : void{}
      
      public function hideIcon(param1:IHallStateView) : void{}
      
      protected function onIconClick(param1:MouseEvent) : void{}
      
      override protected function start() : void{}
      
      public function sendCompose(param1:int) : void{}
   }
}

class inner
{
    
   
   function inner(){super();}
}
