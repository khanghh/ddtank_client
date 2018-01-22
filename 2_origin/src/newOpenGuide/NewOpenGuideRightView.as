package newOpenGuide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class NewOpenGuideRightView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _iconMc:MovieClip;
      
      private var _isDispose:Boolean = false;
      
      public function NewOpenGuideRightView()
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         _bg = ComponentFactory.Instance.creatBitmap("asset.newOpenGuide.rightViewBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("newOpenGuideRightView.titleTxt");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("newOpenGuideRightView.promptTxt");
         _iconMc = ComponentFactory.Instance.creat("asset.newOpenGuide.iconMc");
         _iconMc.x = 1;
         _iconMc.y = 0;
         _iconMc.gotoAndStop(_iconMc.totalFrames);
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_promptTxt);
         addChild(_iconMc);
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(_isDispose)
         {
            return;
         }
         var _loc1_:Array = NewOpenGuideManager.instance.getTitleStrIndexByLevel(PlayerManager.Instance.Self.Grade + 1);
         if(_loc1_[0] == 19)
         {
            _loc1_ = NewOpenGuideManager.instance.getTitleStrIndexByLevel(PlayerManager.Instance.Self.Grade + 2);
         }
         if(_loc1_[0] > 0)
         {
            this.visible = true;
            _titleTxt.text = _loc1_[1];
            _promptTxt.text = LanguageMgr.GetTranslation("newOpenGuide.openPromptStr",_loc1_[2]);
            _iconMc.gotoAndStop(_loc1_[0]);
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleTxt = null;
         _promptTxt = null;
         _iconMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _isDispose = true;
      }
   }
}
