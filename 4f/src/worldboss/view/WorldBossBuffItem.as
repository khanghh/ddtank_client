package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossBuffItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _iconSprite:Sprite;
      
      private var _levelTxt:FilterFrameText;
      
      private var _tipBg:ScaleBitmapImage;
      
      private var _tipTitleTxt:FilterFrameText;
      
      private var _tipDescTxt:FilterFrameText;
      
      public function WorldBossBuffItem(){super();}
      
      private function initView() : void{}
      
      public function updateInfo() : void{}
      
      private function addEvent() : void{}
      
      protected function __update(param1:Event) : void{}
      
      private function showTip(param1:MouseEvent) : void{}
      
      private function hideTip(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
