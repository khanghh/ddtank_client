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
         var tem1:Array = TeamManager.instance.model.onlineTeamMemberList;
         var tem2:Array = TeamManager.instance.model.offlineTeamMemberList;
         tem1 = tem1.sortOn("Grade",16 | 2);
         tem2 = tem2.sortOn("Grade",16 | 2);
         var temp:Array = tem1.concat(tem2);
         return temp;
      }
      
      private function __updateTeamChatList(e:TeamEvent) : void
      {
         member_list.array = teamChatPlayer;
      }
      
      private function __onRenderMemeber(item:Box, index:int) : void
      {
         var info:* = null;
         var nameText:NameTextEx = item.getChildByName("nameText") as NameTextEx;
         var levelIcon:LevelIconEx = item.getChildByName("levelIcon") as LevelIconEx;
         var sexIcon:Clip = item.getChildByName("sexIcon") as Clip;
         if(index < member_list.array.length)
         {
            info = member_list.array[index] as TeamMemberInfo;
            levelIcon.level = info.Grade;
            levelIcon.setInfo(info.Grade,info.ddtKingGrade,info.Repute,info.WinCount,info.TotalCount,info.FightPower,info.Offer,true,false);
            sexIcon.index = !!info.Sex?0:1;
            nameText.text = info.NickName;
            nameText.textType = info && info.IsVIP?2:1;
            if(info.playerState.StateID == 0)
            {
               item.filters = [_myColorMatrix_filter];
            }
            else
            {
               item.filters = null;
            }
            levelIcon.visible = true;
            sexIcon.visible = true;
         }
         else
         {
            levelIcon.visible = false;
            sexIcon.visible = false;
            nameText.text = "";
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
      
      private function __textInput(e:MouseEvent) : void
      {
         e.stopImmediatePropagation();
         e.stopPropagation();
      }
      
      private function __recordHanlder(e:MouseEvent) : void
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
      
      protected function __recordCloseHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         _teamRecordFrame.parent.removeChild(_teamRecordFrame);
         _show = false;
      }
      
      protected function __recordResponseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0)
         {
            SoundManager.instance.play("008");
            _teamRecordFrame.parent.removeChild(_teamRecordFrame);
            _show = false;
         }
      }
      
      private function __minChatView(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.hideTeamChatFrame(PlayerManager.Instance.Self.teamID);
      }
      
      public function addMessage(msg:String) : void
      {
         outputText.text = outputText.text + (msg + "<br/>");
         outputText.textField.setSelection(outputText.text.length - 1,outputText.text.length - 1);
      }
      
      public function addAllMessage(messages:Vector.<String>) : void
      {
         var i:int = 0;
         outputText.text = "";
         for(i = 0; i < messages.length; )
         {
            outputText.text = outputText.text + (messages[i] + "<br/>");
            i++;
         }
         outputText.textField.setSelection(outputText.text.length - 1,outputText.text.length - 1);
      }
      
      protected function __keyUpHandler(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         event.stopPropagation();
         if(event.keyCode == 13)
         {
            __sendHandler(null);
         }
      }
      
      protected function __sendHandler(e:MouseEvent) : void
      {
         var str:* = null;
         SoundManager.instance.play("008");
         if(StringHelper.trim(textInput.text) != "")
         {
            str = textInput.text.replace(/</g,"&lt;").replace(/>/g,"&gt;");
            str = FilterWordManager.filterWrod(str);
            SocketManager.Instance.out.sendTeamChatTalk(PlayerManager.Instance.Self.teamID,str);
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
      
      private function __closeChat(e:MouseEvent) : void
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
      
      protected function __onFrameMoveStart(event:MouseEvent) : void
      {
         StageReferance.stage.addEventListener("mouseMove",__onMoveWindow);
         StageReferance.stage.addEventListener("mouseUp",__onFrameMoveStop);
         startDrag();
      }
      
      protected function __onFrameMoveStop(event:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onFrameMoveStop);
         StageReferance.stage.removeEventListener("mouseMove",__onMoveWindow);
         stopDrag();
      }
      
      protected function __onMoveWindow(event:MouseEvent) : void
      {
         if(DisplayUtils.isInTheStage(new Point(event.localX,event.localY),this))
         {
            event.updateAfterEvent();
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
