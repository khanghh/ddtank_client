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
      
      public function TotemLeftWindowChapterIcon()
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         super();
         _iconList = new Vector.<Bitmap>();
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc1_ = new Bitmap(ClassUtils.CreatInstance("asset.totem.chapterIcon" + _loc2_),"auto",true);
            _iconList.push(_loc1_);
            _loc2_++;
         }
         _iconSprite = new Sprite();
         _iconSprite.addEventListener("mouseOver",showTip,false,0,true);
         _iconSprite.addEventListener("mouseOut",hideTip,false,0,true);
         addChild(_iconSprite);
         _tipView = new TotemLeftWindowChapterTipView();
         _tipView.visible = false;
         LayerManager.Instance.addToLayer(_tipView,2);
      }
      
      public function show(param1:int) : void
      {
         if(_icon && _icon.parent)
         {
            _icon.parent.removeChild(_icon);
         }
         _icon = _iconList[param1 - 1];
         _iconSprite.addChild(_icon);
         _tipView.show(param1);
      }
      
      private function showTip(param1:MouseEvent) : void
      {
         var _loc2_:Point = this.localToGlobal(new Point(_iconSprite.width + 5,_iconSprite.height / 2));
         _tipView.x = _loc2_.x;
         _tipView.y = _loc2_.y;
         _tipView.visible = true;
      }
      
      private function hideTip(param1:MouseEvent) : void
      {
         _tipView.visible = false;
      }
      
      public function dispose() : void
      {
         if(_iconSprite)
         {
            _iconSprite.removeEventListener("mouseOver",showTip);
            _iconSprite.removeEventListener("mouseOut",hideTip);
         }
         ObjectUtils.disposeAllChildren(this);
         _iconList = null;
         _iconSprite = null;
         _icon = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
