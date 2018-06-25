package ddtmatch.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddtmatch.event.DDTMatchEvent;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class DDTMatchMainFrame extends Frame implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _hBox:HBox;
      
      private var _matchBtn:SelectedButton;
      
      private var _expertBtn:SelectedButton;
      
      private var _redPacketBtn:SelectedButton;
      
      private var _fightKingBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _currentIndex:int;
      
      private var _helpBtn:BaseButton;
      
      private var _view;
      
      private var _helpframe:Frame;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _bgHelp:Scale9CornerImage;
      
      public function DDTMatchMainFrame()
      {
         super();
         addEvent();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.mainBg");
         addToContent(_bg);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.view.hBox");
         addToContent(_hBox);
         _matchBtn = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.view.matchBtn");
         _expertBtn = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.view.expertBtn");
         _redPacketBtn = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.view.redPacketBtn");
         _fightKingBtn = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.view.fightKingBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.HelpButton");
         addToContent(_helpBtn);
         _btnGroup = new SelectedButtonGroup();
         if(DDTMatchManager.instance.matchIsBegin)
         {
            _hBox.addChild(_matchBtn);
            _btnGroup.addSelectItem(_matchBtn);
            _view = new DDTMatchView();
         }
         if(DDTMatchManager.instance.expertIsBegin)
         {
            _hBox.addChild(_expertBtn);
            _btnGroup.addSelectItem(_expertBtn);
            if(!_view)
            {
               _view = new DDTMatchExpertView();
            }
            _helpBtn.visible = false;
         }
         if(DDTMatchManager.instance.redPacketIsBegin)
         {
            _hBox.addChild(_redPacketBtn);
            _btnGroup.addSelectItem(_redPacketBtn);
            if(!_view)
            {
               _view = new DDTMatchRedPacketView();
            }
         }
         if(DDTMatchManager.instance.fightKingIsBegin)
         {
            _hBox.addChild(_fightKingBtn);
            _btnGroup.addSelectItem(_fightKingBtn);
            if(!_view)
            {
               _view = new DDTMatchFightKingView();
            }
         }
         var _loc1_:* = 0;
         DDTMatchManager.instance.currentViewType = _loc1_;
         _loc1_ = _loc1_;
         _btnGroup.selectIndex = _loc1_;
         _currentIndex = _loc1_;
         addToContent(_view);
      }
      
      private function addEvent() : void
      {
         _matchBtn.addEventListener("click",__changeHandler);
         _expertBtn.addEventListener("click",__changeHandler);
         _redPacketBtn.addEventListener("click",__changeHandler);
         _fightKingBtn.addEventListener("click",__changeHandler);
         addEventListener("response",_response);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         DDTMatchManager.instance.addEventListener("checkViewClose",checkCloseHandler);
         if(DDTMatchManager.outsideRedPacket)
         {
            _redPacketBtn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function checkCloseHandler(e:DDTMatchEvent) : void
      {
      }
      
      private function __helpBtnClickHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!_helpframe)
         {
            _helpframe = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.frame.help.main");
            _helpframe.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.frame.help.bgHelp");
            _content = ClassUtils.CreatInstance("ddtmatch.helpTxt");
            _content.x = 48;
            _content.y = 81;
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.frame.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpframe.addToContent(_bgHelp);
            _helpframe.addToContent(_content);
            _helpframe.addToContent(_btnOk);
         }
         if(_view is DDTMatchView)
         {
            _content.gotoAndStop(1);
         }
         else if(_view is DDTMatchFightKingView)
         {
            _content.gotoAndStop(2);
         }
         else if(_view is DDTMatchRedPacketView)
         {
            _content.gotoAndStop(3);
         }
         LayerManager.Instance.addToLayer(_helpframe,3,true,2);
      }
      
      private function __helpFrameRespose(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            SoundManager.instance.play("008");
            _helpframe.parent.removeChild(_helpframe);
         }
      }
      
      private function __closeHelpFrame(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpframe.parent.removeChild(_helpframe);
      }
      
      protected function __changeHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!DDTMatchManager.outsideRedPacket)
         {
            if(_btnGroup.selectIndex == _currentIndex)
            {
               return;
            }
         }
         ObjectUtils.disposeObject(_view);
         _view = null;
         _helpBtn.visible = true;
         var _loc2_:* = event.currentTarget;
         if(_matchBtn !== _loc2_)
         {
            if(_expertBtn !== _loc2_)
            {
               if(_redPacketBtn !== _loc2_)
               {
                  if(_fightKingBtn === _loc2_)
                  {
                     _view = new DDTMatchFightKingView();
                  }
               }
               else
               {
                  _view = new DDTMatchRedPacketView();
               }
            }
            else
            {
               _view = new DDTMatchExpertView();
               _helpBtn.visible = false;
            }
         }
         else
         {
            _view = new DDTMatchView();
         }
         DDTMatchManager.outsideRedPacket = false;
         _currentIndex = _btnGroup.selectIndex;
         DDTMatchManager.instance.currentViewType = _btnGroup.selectIndex;
         if(_view)
         {
            addToContent(_view);
         }
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _matchBtn.removeEventListener("click",__changeHandler);
         _expertBtn.removeEventListener("click",__changeHandler);
         _redPacketBtn.removeEventListener("click",__changeHandler);
         _fightKingBtn.removeEventListener("click",__changeHandler);
         removeEventListener("response",_response);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         DDTMatchManager.instance.removeEventListener("checkViewClose",checkCloseHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_matchBtn);
         _matchBtn = null;
         ObjectUtils.disposeObject(_expertBtn);
         _expertBtn = null;
         ObjectUtils.disposeObject(_redPacketBtn);
         _redPacketBtn = null;
         ObjectUtils.disposeObject(_fightKingBtn);
         _fightKingBtn = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_helpframe);
         _helpframe = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_btnOk);
         _btnOk = null;
         ObjectUtils.disposeObject(_bgHelp);
         _bgHelp = null;
         super.dispose();
      }
   }
}
