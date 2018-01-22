package magicStone.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MagicStoneMainView extends Sprite implements Disposeable
   {
       
      
      private var _leftView:MagicStoneInfoView;
      
      private var _bagView:MagicStoneBagView;
      
      private var _btnHelp:BaseButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      public function MagicStoneMainView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _leftView = ComponentFactory.Instance.creatCustomObject("magicStone.infoView");
         addChild(_leftView);
         _bagView = ComponentFactory.Instance.creatCustomObject("magicStone.bagView");
         addChild(_bagView);
         _btnHelp = ComponentFactory.Instance.creatComponentByStylename("cardSystem.texpSystem.btnHelp");
         _btnHelp.x = 734;
         _btnHelp.y = -89;
         addChild(_btnHelp);
      }
      
      private function initEvents() : void
      {
         _btnHelp.addEventListener("click",__helpClick);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_helpFrame)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.main");
            _helpFrame.titleText = LanguageMgr.GetTranslation("magicStone.helpTxt");
            _helpFrame.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.bgHelp");
            _content = ComponentFactory.Instance.creatCustomObject("magicStone.help.content");
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpFrame.addToContent(_bgHelp);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      private function removeEvents() : void
      {
         _btnHelp.removeEventListener("click",__helpClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_btnHelp);
         _btnHelp = null;
      }
   }
}
