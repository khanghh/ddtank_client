package team.view.teamBattle{   import bagAndInfo.cell.BaseCell;   import bagAndInfo.cell.CellFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.HelpFrameUtils;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import morn.core.handlers.Handler;   import team.TeamManager;   import team.view.mornui.TeamBattleFrameUI;      public final class TeamBattleFrame extends TeamBattleFrameUI implements Disposeable   {            private static const TOP_MEMBERS:int = 3;            private static const SEGMENT:Array = [5,4,3,2];                   private var _topList:Vector.<BaseCell>;            private var _segmentList:Vector.<BaseCell>;            private var _btnHelp:BaseButton;            private var _lastCreatTime:int = 0;            public function TeamBattleFrame() { super(); }
            private function initData() : void { }
            private function initEvent() : void { }
            private function showTeamFrame() : void { }
            private function onBalltleBtnHanlder(e:MouseEvent) : void { }
            private function createRoom() : void { }
            private function onClickHandler(event:MouseEvent) : void { }
            private function initView() : void { }
            private function createItemCell() : BaseCell { return null; }
            override public function dispose() : void { }
            private function removeEvent() : void { }
   }}