package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskView;
   import ddt.data.ConsortiaEventInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import road7th.utils.StringHelper;
   
   public class PlacardAndEvent extends Sprite implements Disposeable
   {
       
      
      private var _taskBtn:SelectedTextButton;
      
      private var _placardBtn:SelectedTextButton;
      
      private var _eventBtn:SelectedTextButton;
      
      private var _weekRewardBtn:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _BG:MutipleImage;
      
      private var _placard:TextArea;
      
      private var _editBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _vote:BaseButton;
      
      private var _vbox:VBox;
      
      private var _eventPanel:ScrollPanel;
      
      private var _lastPlacard:String;
      
      private var _myTaskView:ConsortiaTaskView;
      
      private var _consortionRewardSp:ConsortionRewardSp;
      
      public function PlacardAndEvent()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _BG = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.ListBG");
         _taskBtn = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.taskBtn");
         _placardBtn = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.placard");
         _eventBtn = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.event");
         _weekRewardBtn = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.weekReward");
         _placard = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.placardText");
         _editBtn = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.edit");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.cancel");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.eventVbox");
         _eventPanel = ComponentFactory.Instance.creatComponentByStylename("placardAndEvent.eventPanel");
         _vote = ComponentFactory.Instance.creatComponentByStylename("consortion.placardAndEvent.vote");
         _myTaskView = ComponentFactory.Instance.creatCustomObject("ConsortiaTaskView");
         PositionUtils.setPos(_myTaskView,"placardAndEvent.ConsortiaTaskView.pos");
         _taskBtn.text = LanguageMgr.GetTranslation("consortia.PlacardAndEvent.SelectBtnText1");
         _placardBtn.text = LanguageMgr.GetTranslation("consortia.PlacardAndEvent.SelectBtnText2");
         _eventBtn.text = LanguageMgr.GetTranslation("consortia.PlacardAndEvent.SelectBtnText3");
         _weekRewardBtn.text = LanguageMgr.GetTranslation("consortia.PlacardAndEvent.SelectBtnText4");
         addChild(_BG);
         addChild(_taskBtn);
         addChild(_placardBtn);
         addChild(_eventBtn);
         addChild(_weekRewardBtn);
         addChild(_placard);
         addChild(_editBtn);
         addChild(_cancelBtn);
         addChild(_eventPanel);
         addChild(_vote);
         addChild(_myTaskView);
         _eventPanel.setView(_vbox);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_placardBtn);
         _btnGroup.addSelectItem(_eventBtn);
         _btnGroup.addSelectItem(_taskBtn);
         _btnGroup.addSelectItem(_weekRewardBtn);
         _btnGroup.selectIndex = 2;
         _editBtn.text = LanguageMgr.GetTranslation("ok");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         showPlacardOrEvent(_btnGroup.selectIndex);
      }
      
      private function initEvent() : void
      {
         _taskBtn.addEventListener("click",__btnClickHandler);
         _placardBtn.addEventListener("click",__btnClickHandler);
         _eventBtn.addEventListener("click",__btnClickHandler);
         _weekRewardBtn.addEventListener("click",__btnClickHandler);
         _vote.addEventListener("click",__voteHandler);
         _btnGroup.addEventListener("change",__groupChangeHandler);
         _editBtn.addEventListener("click",__editHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _placard.addEventListener("mouseDown",__isClearHandler);
         _placard.textField.addEventListener("change",__inputHandler);
         PlayerManager.Instance.Self.consortiaInfo.addEventListener("propertychange",__placardChangeHandler);
         PlayerManager.Instance.Self.addEventListener("propertychange",__rightChangeHandler);
         ConsortionModelManager.Instance.model.addEventListener("eventListChange",__eventChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_taskBtn)
         {
            _taskBtn.removeEventListener("click",__btnClickHandler);
         }
         if(_placardBtn)
         {
            _placardBtn.removeEventListener("click",__btnClickHandler);
         }
         if(_eventBtn)
         {
            _eventBtn.removeEventListener("click",__btnClickHandler);
         }
         if(_weekRewardBtn)
         {
            _weekRewardBtn.removeEventListener("click",__btnClickHandler);
         }
         if(_vote)
         {
            _vote.removeEventListener("click",__voteHandler);
         }
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__groupChangeHandler);
         }
         if(_editBtn)
         {
            _editBtn.removeEventListener("click",__editHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelHandler);
         }
         if(_placard)
         {
            _placard.removeEventListener("mouseDown",__isClearHandler);
         }
         if(_placard)
         {
            _placard.textField.removeEventListener("change",__inputHandler);
         }
         PlayerManager.Instance.Self.consortiaInfo.removeEventListener("propertychange",__placardChangeHandler);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__rightChangeHandler);
         ConsortionModelManager.Instance.model.removeEventListener("eventListChange",__eventChangeHandler);
      }
      
      private function __voteHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var pollFrame:ConsortionPollFrame = ComponentFactory.Instance.creatComponentByStylename("consortionPollFrame");
         LayerManager.Instance.addToLayer(pollFrame,3,true,1);
         ConsortionModelManager.Instance.loadPollList(PlayerManager.Instance.Self.ConsortiaID);
      }
      
      private function upPlacard() : void
      {
         var str:String = PlayerManager.Instance.Self.consortiaInfo.Placard;
         _placard.text = str == ""?LanguageMgr.GetTranslation("tank.consortia.myconsortia.systemWord"):str;
         _lastPlacard = _placard.text;
         var _loc2_:* = false;
         _cancelBtn.enable = _loc2_;
         _editBtn.enable = _loc2_;
         _vote.visible = PlayerManager.Instance.Self.consortiaInfo.IsVoting;
         _loc2_ = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,8) && _btnGroup.selectIndex == 0;
         _cancelBtn.visible = _loc2_;
         _loc2_ = _loc2_;
         _editBtn.visible = _loc2_;
         _placard.editable = _loc2_;
      }
      
      private function __btnClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __groupChangeHandler(event:Event) : void
      {
         showPlacardOrEvent(_btnGroup.selectIndex);
      }
      
      private function showPlacardOrEvent(type:int) : void
      {
         switch(int(type))
         {
            case 0:
               var _loc2_:* = true;
               _cancelBtn.visible = _loc2_;
               _loc2_ = _loc2_;
               _editBtn.visible = _loc2_;
               _placard.visible = _loc2_;
               _eventPanel.visible = false;
               _myTaskView.visible = false;
               if(_consortionRewardSp)
               {
                  _consortionRewardSp.visible = false;
               }
               upPlacard();
               break;
            case 1:
               _loc2_ = false;
               _cancelBtn.visible = _loc2_;
               _loc2_ = _loc2_;
               _editBtn.visible = _loc2_;
               _placard.visible = _loc2_;
               _eventPanel.visible = true;
               _vote.visible = false;
               _myTaskView.visible = false;
               if(_consortionRewardSp)
               {
                  _consortionRewardSp.visible = false;
               }
               ConsortionModelManager.Instance.loadEventList(ConsortionModelManager.Instance.eventListComplete,PlayerManager.Instance.Self.ConsortiaID);
               break;
            case 2:
               _loc2_ = false;
               _cancelBtn.visible = _loc2_;
               _loc2_ = _loc2_;
               _editBtn.visible = _loc2_;
               _placard.visible = _loc2_;
               _eventPanel.visible = false;
               _vote.visible = false;
               _myTaskView.visible = true;
               if(_consortionRewardSp)
               {
                  _consortionRewardSp.visible = false;
               }
               break;
            case 3:
               if(!_consortionRewardSp)
               {
                  _consortionRewardSp = new ConsortionRewardSp();
                  PositionUtils.setPos(_consortionRewardSp,"consort.consortionRewardSp");
                  addChild(_consortionRewardSp);
               }
               _loc2_ = false;
               _cancelBtn.visible = _loc2_;
               _loc2_ = _loc2_;
               _editBtn.visible = _loc2_;
               _placard.visible = _loc2_;
               _eventPanel.visible = false;
               _vote.visible = false;
               _myTaskView.visible = false;
               _consortionRewardSp.visible = true;
         }
      }
      
      private function __eventChangeHandler(event:ConsortionEvent) : void
      {
         var i:int = 0;
         var item:* = null;
         _vbox.disposeAllChildren();
         var list:Vector.<ConsortiaEventInfo> = ConsortionModelManager.Instance.model.eventList;
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            item = new EventListItem();
            item.info = list[i];
            _vbox.addChild(item);
            i++;
         }
         _eventPanel.invalidateViewport();
      }
      
      private function __editHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var b:ByteArray = new ByteArray();
         b.writeUTF(StringHelper.trim(_placard.textField.text));
         if(b.length > 300)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaAfficheFrame.long"));
            return;
         }
         if(FilterWordManager.isGotForbiddenWords(_placard.textField.text))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaAfficheFrame"));
            return;
         }
         var str:String = FilterWordManager.filterWrod(_placard.textField.text);
         str = StringHelper.trim(str);
         SocketManager.Instance.out.sendConsortiaUpdatePlacard(str);
         var _loc4_:Boolean = false;
         _cancelBtn.enable = _loc4_;
         _editBtn.enable = _loc4_;
      }
      
      private function __cancelHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _placard.text = _lastPlacard;
         var _loc2_:Boolean = false;
         _cancelBtn.enable = _loc2_;
         _editBtn.enable = _loc2_;
      }
      
      private function __isClearHandler(event:MouseEvent) : void
      {
         if(_placard.editable)
         {
            _placard.text = _placard.text == LanguageMgr.GetTranslation("tank.consortia.myconsortia.systemWord")?"":_placard.text;
         }
      }
      
      private function __inputHandler(event:Event) : void
      {
         var _loc2_:Boolean = true;
         _cancelBtn.enable = _loc2_;
         _editBtn.enable = _loc2_;
         StringHelper.checkTextFieldLength(_placard.textField,200);
      }
      
      private function __placardChangeHandler(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["placard"] || event.changedProperties["isVoting"])
         {
            upPlacard();
         }
      }
      
      private function __rightChangeHandler(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Right"])
         {
            upPlacard();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_vbox)
         {
            _vbox.disposeAllChildren();
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_taskBtn)
         {
            ObjectUtils.disposeObject(_taskBtn);
         }
         _taskBtn = null;
         if(_myTaskView)
         {
            ObjectUtils.disposeObject(_myTaskView);
         }
         _myTaskView = null;
         if(_placardBtn)
         {
            ObjectUtils.disposeObject(_placardBtn);
         }
         _placardBtn = null;
         if(_eventBtn)
         {
            ObjectUtils.disposeObject(_eventBtn);
         }
         _eventBtn = null;
         ObjectUtils.disposeObject(_weekRewardBtn);
         _weekRewardBtn = null;
         ObjectUtils.disposeObject(_consortionRewardSp);
         _consortionRewardSp = null;
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_placard)
         {
            ObjectUtils.disposeObject(_placard);
         }
         _placard = null;
         if(_editBtn)
         {
            ObjectUtils.disposeObject(_editBtn);
         }
         _editBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         if(_vote)
         {
            ObjectUtils.disposeObject(_vote);
         }
         _vote = null;
         if(_eventPanel)
         {
            ObjectUtils.disposeObject(_eventPanel);
         }
         _eventPanel = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
