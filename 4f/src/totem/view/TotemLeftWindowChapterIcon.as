package totem.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TotemLeftWindowChapterIcon extends Sprite implements Disposeable
   {
       
      
      private var _iconList:Vector.<Bitmap>;
      
      private var _iconSprite:Sprite;
      
      private var _icon:Bitmap;
      
      private var _tipView:TotemLeftWindowChapterTipView;
      
      public function TotemLeftWindowChapterIcon(){super();}
      
      public function show(param1:int) : void{}
      
      private function showTip(param1:MouseEvent) : void{}
      
      private function hideTip(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
