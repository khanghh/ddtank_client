package team.view.im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.im.TeamRecordFrame;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import morn.core.components.Box;
   import morn.core.components.Clip;
   import morn.core.ex.LevelIconEx;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import road7th.utils.StringHelper;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamChat.TeamChatUI;
   
   public class TeamIMFrame extends TeamChatUI
   {
       
      
      private var _teamRecordFrame:TeamRecordFrame;
      
      private var _moveRect:Sprite;
      
      private var _show:Boolean = false;
      
      private var _info:PlayerInfo;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      public function TeamIMFrame()
      {
         _myColorMatrix_filter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         sendBtn.tipStyle = "ddt.view.tips.OneLineTip";
         sendBtn.tipDirctions = "0";
         sendBtn.tipGapV = 5;
         sendBtn.tipData = LanguageMgr.GetTranslation("IM.privateChatFrame.send.tipdata");
         sendBtn.label = LanguageMgr.GetTranslation("ddt.team.allView.text17");
         member_list.renderHandler = new Handler(__onRenderMemeber);
         member_list.array = teamChatPlayer;
         updateMoveRect();
         teamText1.text = LanguageMgr.GetTranslation("ddt.team.allView.text18");
         teamText2.text = LanguageMgr.GetTranslation("ddt.team.allView.text19");
      }
      
      private function get teamChatPlayer() : Array
      {
         var _loc2_:Array = TeamManager.instance.model.onlineTeamMemberList;
         var _loc3_:Array = TeamManager.instance.model.offlineTeamMemberList;
         _loc2_ = _loc2_.sortOn("Grade",16 | 2);
         _loc3_ = _loc3_.sortOn("Grade",16 | 2);
         var _loc1_:Array = _loc2_.concat(_loc3_);
         return _loc1_;
      }
      
      private function __updateTeamChatList(param1:TeamEvent) : void
      {
         member_list.array = teamChatPlayer;
      }
      
      private function __onRenderMemeber(param1:Box, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc4_:NameTextEx = param1.getChildByName("nameText") as NameTextEx;
         var _loc3_:LevelIconEx = param1.getChildByName("levelIcon") as LevelIconEx;
         var _loc5_:Clip = param1.getChildByName("sexIcon") as Clip;
         if(param2 < member_list.array.length)
         {
            _loc6_ = member_list.array[param2] as TeamMemberInfo;
            _loc3_.level = _loc6_.Grade;
            _loc3_.setInfo(_loc6_.Grade,_loc6_.ddtKingGrade,_loc6_.Repute,_loc6_.WinCount,_loc6_.TotalCount,_loc6_.FightPower,_loc6_.Offer,true,false);
            _loc5_.index = !!_loc6_.Sex?0:1;
            _loc4_.text = _loc6_.NickName;
            _loc4_.textType = _loc6_ && _loc6_.IsVIP?2:1;
            if(_loc6_.playerState.StateID == 0)
            {
               param1.filters = [_myColorMatrix_filter];
            }
            else
            {
               param1.filters = null;
            }
            _loc3_.visible = true;
            _loc5_.visible = true;
         }
         else
         {
            _loc3_.visible = false;
            _loc5_.visible = false;
            _loc4_.text = "";
         }
      }
      
      private function addEvent() : void
      {
         textInput.addEventListener("keyDown",__keyUpHandler);
         closeBtn.addEventListener("click",__closeChat);
         sendBtn.addEventListener("click",__sendHandler);
         textInput.removeEventListener("click",__textInput);
         minBtn.addEventListener("click",__minChatView);
         showRecordBtn.addEventListener("click",__recordHanlder);
         TeamManager.instance.addEventListener("updateteammember",__updateTeamChatList);
      }
      
      private function __textInput(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __recordHanlder(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_teamRecordFrame == null)
         {
            _teamRecordFrame = ComponentFactory.Instance.creatComponentByStylename("teamRecordFrame");
            _teamRecordFrame.addEventListener("response",__recordResponseHandler);
            _teamRecordFrame.addEventListener("close",__recordCloseHandler);
            PositionUtils.setPos(_teamRecordFrame,"teamRecordFrame.pos");
         }
         if(!_show)
         {
            addChild(_teamRecordFrame);
            _teamRecordFrame.teamId = PlayerManager.Instance.Self.teamID;
            _show = true;
         }
         else
         {
            closeRecordFrame();
         }
      }
      
      private function closeRecordFrame() : void
      {
         if(_teamRecordFrame && _teamRecordFrame.parent)
         {
            _teamRecordFrame.parent.removeChild(_teamRecordFrame);
         }
         _show = false;
      }
      
      protected function __recordCloseHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _teamRecordFrame.parent.removeChild(_teamRecordFrame);
         _show = false;
      }
      
      protected function __recordResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0)
         {
            SoundManager.instance.play("008");
            _teamRecordFrame.parent.removeChild(_teamRecordFrame);
            _show = false;
         }
      }
      
      private function __minChatView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.hideTeamChatFrame(PlayerManager.Instance.Self.teamID);
      }
      
      public function addMessage(param1:String) : void
      {
         outputText.text = outputText.text + (param1 + "<br/>");
         outputText.textField.setSelection(outputText.text.length - 1,outputText.text.length - 1);
      }
      
      public function addAllMessage(param1:Vector.<String>) : void
      {
         var _loc2_:int = 0;
         outputText.text = "";
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            outputText.text = outputText.text + (param1[_loc2_] + "<br/>");
            _loc2_++;
         }
         outputText.textField.setSelection(outputText.text.length - 1,outputText.text.length - 1);
      }
      
      protected function __keyUpHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         if(param1.keyCode == 13)
         {
            __sendHandler(null);
         }
      }
      
      protected function __sendHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(StringHelper.trim(textInput.text) != "")
         {
            _loc2_ = textInput.text.replace(/</g,"&lt;").replace(/>/g,"&gt;");
            _loc2_ = FilterWordManager.filterWrod(_loc2_);
            SocketManager.Instance.out.sendTeamChatTalk(PlayerManager.Instance.Self.teamID,_loc2_);
            textInput.text = "";
         }
         else
         {
            textInput.text = "";
         }
      }
      
      private function removeEvent() : void
      {
         textInput.removeEventListener("keyUp",__keyUpHandler);
         minBtn.removeEventListener("click",__minChatView);
         closeBtn.removeEventListener("click",__closeChat);
         textInput.removeEventListener("click",__textInput);
         sendBtn.addEventListener("click",__sendHandler);
         showRecordBtn.removeEventListener("click",__recordHanlder);
         TeamManager.instance.removeEventListener("updateteammember",__updateTeamChatList);
      }
      
      private function __closeChat(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.disposeTeamChatFrame();
      }
      
      private function updateMoveRect() : void
      {
         _moveRect = new Sprite();
         _moveRect.graphics.clear();
         _moveRect.graphics.beginFill(0,0);
         _moveRect.graphics.drawRect(-51,-13,465,25);
         _moveRect.graphics.endFill();
         addChild(_moveRect);
         _moveRect.addEventListener("mouseDown",__onFrameMoveStart);
      }
      
      protected function __onFrameMoveStart(param1:MouseEvent) : void
      {
         StageReferance.stage.addEventListener("mouseMove",__onMoveWindow);
         StageReferance.stage.addEventListener("mouseUp",__onFrameMoveStop);
         startDrag();
      }
      
      protected function __onFrameMoveStop(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onFrameMoveStop);
         StageReferance.stage.removeEventListener("mouseMove",__onMoveWindow);
         stopDrag();
      }
      
      protected function __onMoveWindow(param1:MouseEvent) : void
      {
         if(DisplayUtils.isInTheStage(new Point(param1.localX,param1.localY),this))
         {
            param1.updateAfterEvent();
         }
         else
         {
            __onFrameMoveStop(null);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_teamRecordFrame)
         {
            _teamRecordFrame.removeEventListener("response",__recordResponseHandler);
            _teamRecordFrame.removeEventListener("close",__recordCloseHandler);
            _teamRecordFrame.dispose();
            _teamRecordFrame = null;
         }
         if(_moveRect)
         {
            _moveRect.removeEventListener("mouseDown",__onFrameMoveStart);
         }
         ObjectUtils.disposeObject(_moveRect);
         _moveRect = null;
         _info = null;
         super.dispose();
      }
   }
}
