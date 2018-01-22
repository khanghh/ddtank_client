package boguAdventure.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BoguAdventureHelpFrame extends Sprite implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _bg:Bitmap;
      
      private var _box:Sprite;
      
      private var _helpBtn:SelectedButton;
      
      private var _flag:Boolean;
      
      public function BoguAdventureHelpFrame()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _box = new Sprite();
         addChild(_box);
         _helpBtn = UICreatShortcut.creatAndAdd("boguAdventure.helpBtn",this);
         _bg = UICreatShortcut.creatAndAdd("boguAdventure.helpBg",_box);
         _panel = UICreatShortcut.creatAndAdd("boguAdventure.helpPanel",_box);
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creat("boguAdventure.helpText");
         _loc1_.htmlText = LanguageMgr.GetTranslation("boguAdventure.view.helpText");
         _panel.setView(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215);
         _loc2_.graphics.drawRect(0,0,220,303);
         addChild(_loc2_);
         PositionUtils.setPos(_loc2_,"boguAdventure.helpMaskPos");
         _box.mask = _loc2_;
         _box.y = -_bg.height;
         _flag = true;
         _helpBtn.addEventListener("click",__onHelpClick);
      }
      
      private function __onHelpClick(param1:MouseEvent) : void
      {
         TweenLite.killTweensOf(_box);
         if(_flag)
         {
            TweenLite.to(_box,0.3,{"y":0});
            _flag = false;
         }
         else
         {
            TweenLite.to(_box,0.3,{"y":-_bg.height});
            _flag = true;
         }
      }
      
      public function dispose() : void
      {
         TweenLite.killTweensOf(_box);
         _helpBtn.removeEventListener("click",__onHelpClick);
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _box = null;
      }
   }
}
