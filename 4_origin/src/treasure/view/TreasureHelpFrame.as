package treasure.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TreasureHelpFrame extends Sprite implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _contents:MovieClip;
      
      private var _bg:ScaleUpDownImage;
      
      private var _box:Sprite;
      
      private var _btn:SelectedTextButton;
      
      private var _mask:Sprite;
      
      private var flag:Boolean;
      
      private var frameHead:Bitmap;
      
      public function TreasureHelpFrame()
      {
         super();
         init();
         initListener();
      }
      
      private function init() : void
      {
         _box = new Sprite();
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.treasure.helpFrame.BG");
         _panel = ComponentFactory.Instance.creatComponentByStylename("treasure.helpPanel");
         _contents = ComponentFactory.Instance.creat("asset.treasure.help.contents");
         _btn = ComponentFactory.Instance.creatComponentByStylename("treasure.helpBtn");
         frameHead = ComponentFactory.Instance.creatBitmap("asset.treasure.help.frameUp");
         addChild(_panel);
         _box.addChild(_bg);
         frameHead.x = 9;
         frameHead.y = 18;
         _panel.setView(_contents);
         _box.addChild(_panel);
         addChild(_box);
         _mask = new Sprite();
         _mask.graphics.beginFill(16777215);
         _mask.graphics.drawRect(0,0,282,270);
         PositionUtils.setPos(_mask,"help.mask.pos");
         addChild(_mask);
         _box.mask = _mask;
         _box.y = -_box.height;
         addChild(_btn);
         addChild(frameHead);
         frameHead.visible = false;
         flag = true;
      }
      
      private function initListener() : void
      {
         _btn.addEventListener("click",_btnClickHandler);
      }
      
      private function _btnClickHandler(param1:MouseEvent) : void
      {
         frameHead.visible = true;
         TweenLite.killTweensOf(_box);
         if(flag)
         {
            TweenLite.to(_box,0.3,{"y":0});
            flag = false;
         }
         else
         {
            TweenLite.to(_box,0.3,{
               "y":-_bg.height + 20,
               "onComplete":outhandler
            });
            flag = true;
         }
      }
      
      private function outhandler() : void
      {
         frameHead.visible = false;
      }
      
      private function removeListener() : void
      {
         _btn.removeEventListener("click",_btnClickHandler);
      }
      
      public function dispose() : void
      {
         removeListener();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_mask)
         {
            ObjectUtils.disposeObject(_mask);
         }
         _mask = null;
         if(_btn)
         {
            ObjectUtils.disposeObject(_btn);
         }
         _btn = null;
         if(frameHead)
         {
            ObjectUtils.disposeObject(frameHead);
         }
         frameHead = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(_contents)
         {
            ObjectUtils.disposeObject(_contents);
         }
         _contents = null;
         if(_box)
         {
            ObjectUtils.disposeObject(_box);
         }
         _box = null;
      }
   }
}
