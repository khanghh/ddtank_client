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
      
      public function DdtKingLettersCollectManager(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : DdtKingLettersCollectManager
      {
         if(!instance)
         {
            instance = new DdtKingLettersCollectManager(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         if(NationDayManager.instance.curActivity != "lt_ddt_king")
         {
            return;
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(288,1),__onGetHideTitleFlag);
      }
      
      protected function __onGetHideTitleFlag(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _isOpen = _loc2_.readBoolean();
         if(_isOpen)
         {
            showIcon(_hall);
         }
         else
         {
            hideIcon(_hall);
         }
      }
      
      public function showIcon(param1:IHallStateView) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_isOpen)
         {
            _hall = param1;
            if(_icon != null)
            {
               _icon.removeEventListener("click",onIconClick);
               ObjectUtils.disposeObject(_icon);
               _icon = null;
            }
            _icon = ComponentFactory.Instance.creat("asset.hall.dkletter.icon");
            _icon.mouseChildren = false;
            _icon.useHandCursor = true;
            _icon.buttonMode = true;
            _icon.addEventListener("click",onIconClick);
         }
      }
      
      public function hideIcon(param1:IHallStateView) : void
      {
         _hall = null;
         if(_icon)
         {
            _icon.removeEventListener("click",onIconClick);
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
      }
      
      protected function onIconClick(param1:MouseEvent) : void
      {
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("dklc_show"));
      }
      
      public function sendCompose(param1:int) : void
      {
         SocketManager.Instance.out.exchangeNationalGoods(param1);
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
