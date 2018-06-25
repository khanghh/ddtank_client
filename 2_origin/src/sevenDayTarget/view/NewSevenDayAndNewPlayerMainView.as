package sevenDayTarget.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import sevenDayTarget.controller.NewSevenDayAndNewPlayerManager;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   
   public class NewSevenDayAndNewPlayerMainView extends Frame
   {
       
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _sevenDayBtn:SelectedButton;
      
      private var _newPlayerBtn:SelectedButton;
      
      private var _sevenDayMainView:SevenDayTargetMainView;
      
      private var _newPlayerRewardMainView:NewPlayerRewardMainView;
      
      public function NewSevenDayAndNewPlayerMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _sevenDayBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDay.sevenDayBtn");
         _newPlayerBtn = ComponentFactory.Instance.creatComponentByStylename("sevenDay.newPlayerBtn");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addEventListener("change",__changeHandler);
         if(NewSevenDayAndNewPlayerManager.Instance.sevenDayOpen && NewSevenDayAndNewPlayerManager.Instance.newPlayerOpen)
         {
            _sevenDayMainView = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.sevenDayTargetFrame");
            addToContent(_sevenDayMainView);
            _newPlayerRewardMainView = new NewPlayerRewardMainView();
            addToContent(_newPlayerRewardMainView);
            addToContent(_sevenDayBtn);
            addToContent(_newPlayerBtn);
            _btnGroup.addSelectItem(_sevenDayBtn);
            _btnGroup.addSelectItem(_newPlayerBtn);
            _btnGroup.selectIndex = 0;
         }
         else if(NewSevenDayAndNewPlayerManager.Instance.sevenDayOpen && NewSevenDayAndNewPlayerManager.Instance.newPlayerOpen == false)
         {
            _sevenDayMainView = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.sevenDayTargetFrame");
            addToContent(_sevenDayMainView);
            addToContent(_sevenDayBtn);
            _btnGroup.addSelectItem(_sevenDayBtn);
            _btnGroup.selectIndex = 0;
         }
         else if(NewSevenDayAndNewPlayerManager.Instance.sevenDayOpen == false && NewSevenDayAndNewPlayerManager.Instance.newPlayerOpen)
         {
            _newPlayerRewardMainView = new NewPlayerRewardMainView();
            addToContent(_newPlayerRewardMainView);
            addToContent(_newPlayerBtn);
            PositionUtils.setPos(_newPlayerBtn,"sevenDayAndNewPlayer.newPlayerBntPos");
            _newPlayerBtn.selected = true;
         }
         else
         {
            dispose();
         }
      }
      
      private function __changeHandler(event:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(_sevenDayMainView)
               {
                  _sevenDayMainView.visible = true;
               }
               if(_newPlayerRewardMainView)
               {
                  _newPlayerRewardMainView.visible = false;
               }
               break;
            case 1:
               if(_sevenDayMainView)
               {
                  _sevenDayMainView.visible = false;
               }
               if(_newPlayerRewardMainView)
               {
                  _newPlayerRewardMainView.visible = true;
                  break;
               }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               NewSevenDayAndNewPlayerManager.Instance.hideMainView();
         }
      }
      
      public function todayInfo() : NewTargetQuestionInfo
      {
         if(_sevenDayMainView)
         {
            return _sevenDayMainView.todayQuestInfo;
         }
         return null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         NewSevenDayAndNewPlayerManager.Instance.newPlayerMainViewPreOk = false;
         NewSevenDayAndNewPlayerManager.Instance.sevenDayMainViewPreOk = false;
      }
   }
}
