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
      
      public function DdtKingLettersCollectManager(single:inner)
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
      
      protected function __onGetHideTitleFlag(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _isOpen = pkg.readBoolean();
         if(_isOpen)
         {
            showIcon(_hall);
         }
         else
         {
            hideIcon(_hall);
         }
      }
      
      public function showIcon($hall:IHallStateView) : void
      {
         if($hall == null)
         {
            return;
         }
         if(_isOpen)
         {
            _hall = $hall;
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
      
      public function hideIcon($hall:IHallStateView) : void
      {
         _hall = null;
         if(_icon)
         {
            _icon.removeEventListener("click",onIconClick);
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
      }
      
      protected function onIconClick(e:MouseEvent) : void
      {
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new CEvent("dklc_show"));
      }
      
      public function sendCompose($templeteID:int) : void
      {
         SocketManager.Instance.out.exchangeNationalGoods($templeteID);
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
