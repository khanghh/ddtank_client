package bombKing.components
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BKingPlayerTip extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _viewInfo:IconButton;
      
      private var userId:int;
      
      private var areaId:int;
      
      public function BKingPlayerTip()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("bombKing.tipsBg");
         addChild(_bg);
         _viewInfo = ComponentFactory.Instance.creatComponentByStylename("bombKing.viewInfo");
         addChild(_viewInfo);
      }
      
      private function initEvents() : void
      {
         _viewInfo.addEventListener("click",__onViewInfo);
      }
      
      protected function __onViewInfo(param1:MouseEvent) : void
      {
         if(userId)
         {
            PlayerInfoViewControl.viewByID(userId,areaId,true,false,true);
            PlayerInfoViewControl.isOpenFromBag = false;
         }
      }
      
      public function setUserId(param1:int, param2:int) : void
      {
         this.userId = param1;
         this.areaId = param2;
      }
      
      private function removeEvents() : void
      {
         _viewInfo.addEventListener("click",__onViewInfo);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_viewInfo);
         _viewInfo = null;
      }
   }
}
