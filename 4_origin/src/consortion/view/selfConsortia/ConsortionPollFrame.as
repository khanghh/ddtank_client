package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionPollInfo;
   import consortion.event.ConsortionEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortionPollFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _name:FilterFrameText;
      
      private var _ticketCount:FilterFrameText;
      
      private var _vote:BaseButton;
      
      private var _help:BaseButton;
      
      private var _mark:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _items:Vector.<ConsortionPollItem>;
      
      private var _currentItem:ConsortionPollItem;
      
      private var _helpFrame:Frame;
      
      private var _helpContentBG:Scale9CornerImage;
      
      private var _helpContent:MovieImage;
      
      private var _helpClose:TextButton;
      
      public function ConsortionPollFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("ddt.consortion.pollFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.bg");
         _name = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.name");
         _name.text = LanguageMgr.GetTranslation("tank.consortion.pollFrame.name.text");
         _ticketCount = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.ticketCount");
         _ticketCount.text = LanguageMgr.GetTranslation("tank.consortion.pollFrame.ticketCount.text");
         _vote = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.vote");
         _help = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.help");
         _mark = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.mark");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.vbox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.panel");
         addToContent(_bg);
         addToContent(_name);
         addToContent(_ticketCount);
         addToContent(_vote);
         addToContent(_help);
         addToContent(_mark);
         addToContent(_panel);
         _panel.setView(_vbox);
         dataList = ConsortionModelManager.Instance.model.pollList;
         _mark.text = LanguageMgr.GetTranslation("ddt.consortion.pollFrame.continueDay",PlayerManager.Instance.Self.consortiaInfo.VoteRemainDay);
         if(PlayerManager.Instance.Self.Riches < 100 || ConsortionModelManager.Instance.model.getConsortiaMemberInfo(PlayerManager.Instance.Self.ID).IsVote)
         {
            _vote.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _vote.addEventListener("click",__voteHandler);
         _help.addEventListener("click",__helpHandler);
         ConsortionModelManager.Instance.model.addEventListener("pollListChange",__pollListChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(129,25),__consortiaPollHandler);
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         removeEventListener("response",__responseHandler);
         _vote.removeEventListener("click",__voteHandler);
         _help.removeEventListener("click",__helpHandler);
         ConsortionModelManager.Instance.model.removeEventListener("pollListChange",__pollListChange);
         for(i = 0; i < _items.length; )
         {
            _items[i].removeEventListener("click",__itemClickHandler);
            i++;
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(129,25),__consortiaPollHandler);
      }
      
      private function __consortiaPollHandler(evt:PkgEvent) : void
      {
         var isSuccess:Boolean = evt.pkg.readBoolean();
         if(isSuccess)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.pollFrame.success"));
            ConsortionModelManager.Instance.model.getConsortiaMemberInfo(PlayerManager.Instance.Self.ID).IsVote = true;
            dispose();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.pollFrame.fail"));
            _vote.enable = true;
         }
      }
      
      private function __pollListChange(event:ConsortionEvent) : void
      {
         dataList = ConsortionModelManager.Instance.model.pollList;
      }
      
      private function clearList() : void
      {
         var i:int = 0;
         if(_items)
         {
            for(i = 0; i < _items.length; )
            {
               _items[i].removeEventListener("click",__itemClickHandler);
               _items[i].dispose();
               _items[i] = null;
               i++;
            }
         }
         _items = new Vector.<ConsortionPollItem>();
      }
      
      private function set dataList(value:Vector.<ConsortionPollInfo>) : void
      {
         var i:int = 0;
         var item:* = null;
         clearList();
         if(value == null)
         {
            return;
         }
         i = 0;
         while(i < value.length)
         {
            item = new ConsortionPollItem(i);
            item.addEventListener("click",__itemClickHandler);
            item.info = value[i];
            _items.push(item);
            _vbox.addChild(item);
            i++;
         }
         _panel.invalidateViewport();
      }
      
      private function __itemClickHandler(event:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         _currentItem = event.currentTarget as ConsortionPollItem;
         for(i = 0; i < _items.length; )
         {
            if(_currentItem == _items[i])
            {
               _items[i].selected = true;
            }
            else
            {
               _items[i].selected = false;
            }
            i++;
         }
      }
      
      private function __responseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __voteHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_currentItem == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.pollFrame.pleaseSelceted"));
            return;
         }
         if(ConsortionModelManager.Instance.model.getConsortiaMemberInfo(PlayerManager.Instance.Self.ID).IsVote)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.pollFrame.double"));
            return;
         }
         SocketManager.Instance.out.sendConsortionPoll(_currentItem.info.pollID);
         _vote.enable = false;
      }
      
      private function __helpHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _helpFrame = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.helpFrame");
         _helpContentBG = ComponentFactory.Instance.creatComponentByStylename("consortion.consortion.pollFrame.helpFrame.bg");
         _helpContent = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.explain");
         _helpClose = ComponentFactory.Instance.creatComponentByStylename("consortion.pollFrame.helpFrame.close");
         _helpFrame.addToContent(_helpContentBG);
         _helpFrame.addToContent(_helpContent);
         _helpFrame.addToContent(_helpClose);
         _helpFrame.escEnable = true;
         _helpFrame.disposeChildren = true;
         _helpFrame.titleText = LanguageMgr.GetTranslation("ddt.consortion.pollFrame.helpFrame.title");
         _helpClose.text = LanguageMgr.GetTranslation("close");
         _helpFrame.addEventListener("response",__helpResoponseHandler);
         _helpClose.addEventListener("click",__closeHelpHandler);
         LayerManager.Instance.addToLayer(_helpFrame,3,true,1);
      }
      
      private function __helpResoponseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1)
         {
            SoundManager.instance.play("008");
            helpDispose();
         }
      }
      
      private function __closeHelpHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         helpDispose();
      }
      
      private function helpDispose() : void
      {
         _helpFrame.removeEventListener("response",__helpResoponseHandler);
         _helpClose.removeEventListener("click",__closeHelpHandler);
         _helpFrame.dispose();
         _helpContent = null;
         _helpClose = null;
         if(_helpFrame.parent)
         {
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearList();
         super.dispose();
         _bg = null;
         _name = null;
         _ticketCount = null;
         _vote = null;
         _help = null;
         _mark = null;
         _vbox = null;
         _panel = null;
         _items = null;
         _currentItem = null;
         _helpContentBG = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
