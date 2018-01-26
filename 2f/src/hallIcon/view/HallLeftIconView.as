package hallIcon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import hallIcon.event.HallIconEvent;
   import hallIcon.info.HallIconInfo;
   import kingBless.KingBlessManager;
   import vip.VipController;
   
   public class HallLeftIconView extends Sprite implements Disposeable
   {
       
      
      private var _iconVBox:VBox;
      
      private var _expblessedIcon:Component;
      
      private var _vipLvlIcon:MovieClip;
      
      private var _kingBlessIcon:Component;
      
      public function HallLeftIconView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function addChildBox(param1:DisplayObject) : void{}
      
      private function updateExpblessedIcon() : void{}
      
      private function __updateLeftIconView(param1:HallIconEvent) : void{}
      
      private function updateVipLvlIcon() : void{}
      
      private function __vipLvlIconClickHandler(param1:MouseEvent) : void{}
      
      private function updateKingBlessIcon() : void{}
      
      private function __kingBlessIconClickHandler(param1:MouseEvent) : void{}
      
      private function createComponentIcon(param1:String) : Component{return null;}
      
      private function removeEvent() : void{}
      
      private function removeVipLvlIcon() : void{}
      
      private function removeExpblessedIcon() : void{}
      
      private function removeKingBlessIcon() : void{}
      
      public function dispose() : void{}
   }
}
