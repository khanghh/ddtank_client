package consortionBattle.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import consortionBattle.event.ConsBatEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsBatScoreView extends Sprite implements Disposeable
   {
       
      
      private var _moveOutBtn:SimpleBitmapButton;
      
      private var _moveInBtn:SimpleBitmapButton;
      
      private var _playerBtn:SelectedButton;
      
      private var _consortiaBtn:SelectedButton;
      
      private var _playerBg:Bitmap;
      
      private var _consortiaBg:Bitmap;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:ListPanel;
      
      private var _selfScoreTxt:FilterFrameText;
      
      private var _consortiaScoreList:Array;
      
      private var _playerScoreList:Array;
      
      private var _timer:TimerJuggler;
      
      public function ConsBatScoreView()
      {
         super();
         this.x = 803;
         this.y = 183;
         initView();
         initEvent();
         _timer = TimerManager.getInstance().addTimerJuggler(5000);
         _timer.addEventListener("timer",timerHandler,false,0,true);
         _timer.start();
         _btnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _moveOutBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.moveOutBtn");
         _moveInBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.moveInBtn");
         setInOutVisible(true);
         _playerBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.playerBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.consortiaBtn");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_consortiaBtn);
         _btnGroup.addSelectItem(_playerBtn);
         _playerBg = ComponentFactory.Instance.creatBitmap("asset.consortiaBattle.scoreView.player.bg");
         _consortiaBg = ComponentFactory.Instance.creatBitmap("asset.consortiaBattle.scoreView.consortia.bg");
         _selfScoreTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.selfTxt");
         _selfScoreTxt.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.scoreView.selfScoreTxt") + ConsortiaBattleManager.instance.score;
         _list = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.scoreView.list");
         addChild(_moveOutBtn);
         addChild(_moveInBtn);
         addChild(_playerBtn);
         addChild(_consortiaBtn);
         addChild(_playerBg);
         addChild(_consortiaBg);
         addChild(_selfScoreTxt);
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         _moveOutBtn.addEventListener("click",outHandler,false,0,true);
         _moveInBtn.addEventListener("click",inHandler,false,0,true);
         _btnGroup.addEventListener("change",__changeHandler,false,0,true);
         _playerBtn.addEventListener("click",__soundPlay,false,0,true);
         _consortiaBtn.addEventListener("click",__soundPlay,false,0,true);
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleUpdateScore",updateScore);
      }
      
      private function updateScore(param1:ConsBatEvent) : void
      {
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc8_:int = _loc6_.readByte();
         if(_loc8_ == 1)
         {
            _consortiaScoreList = [];
            _loc3_ = _loc6_.readInt();
            _loc10_ = 0;
            while(_loc10_ < _loc3_)
            {
               _loc5_ = {};
               _loc5_.name = _loc6_.readUTF();
               _loc5_.rank = _loc6_.readInt();
               _loc5_.score = _loc6_.readInt();
               _consortiaScoreList.push(_loc5_);
               _loc10_++;
            }
            _consortiaScoreList.sortOn("score",16 | 2);
            _loc9_ = 0;
            while(_loc9_ < _loc3_)
            {
               _consortiaScoreList[_loc9_].rank = _loc9_ + 1;
               _loc9_++;
            }
         }
         else
         {
            _playerScoreList = [];
            _loc4_ = _loc6_.readInt();
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc2_ = {};
               _loc2_.name = _loc6_.readUTF();
               _loc2_.rank = _loc6_.readInt();
               _loc2_.score = _loc6_.readInt();
               _playerScoreList.push(_loc2_);
               _loc7_++;
            }
            _playerScoreList.sortOn("rank",16);
         }
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _list.vectorListModel.clear();
               _list.vectorListModel.appendAll(_consortiaScoreList);
               _list.list.updateListView();
               break;
            case 1:
               _list.vectorListModel.clear();
               _list.vectorListModel.appendAll(_playerScoreList);
               _list.list.updateListView();
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _playerBg.visible = false;
               _consortiaBg.visible = true;
               _list.y = 13;
               _selfScoreTxt.visible = false;
               _consortiaBtn.x = 8;
               _consortiaBtn.y = -32;
               _playerBtn.x = 93;
               _playerBtn.y = -26;
               _list.vectorListModel.clear();
               _list.vectorListModel.appendAll(_consortiaScoreList);
               _list.list.updateListView();
               _timer.reset();
               _timer.start();
               SocketManager.Instance.out.sendConsBatUpdateScore(1);
               break;
            case 1:
               _playerBg.visible = true;
               _consortiaBg.visible = false;
               _list.y = 37;
               _selfScoreTxt.visible = true;
               _consortiaBtn.x = 6;
               _consortiaBtn.y = -26;
               _playerBtn.x = 85;
               _playerBtn.y = -31;
               _list.vectorListModel.clear();
               _list.vectorListModel.appendAll(_playerScoreList);
               _list.list.updateListView();
               _timer.reset();
               _timer.start();
               SocketManager.Instance.out.sendConsBatUpdateScore(2);
         }
      }
      
      private function timerHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_btnGroup.selectIndex == 0)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = 2;
         }
         SocketManager.Instance.out.sendConsBatUpdateScore(_loc2_);
      }
      
      private function __soundPlay(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(false);
         TweenLite.to(this,0.5,{"x":999});
      }
      
      private function setInOutVisible(param1:Boolean) : void
      {
         _moveOutBtn.visible = param1;
         _moveInBtn.visible = !param1;
      }
      
      private function inHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(true);
         TweenLite.to(this,0.5,{"x":803});
      }
      
      private function removeEvent() : void
      {
         _moveOutBtn.removeEventListener("click",outHandler);
         _moveInBtn.removeEventListener("click",inHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _playerBtn.removeEventListener("click",__soundPlay);
         _consortiaBtn.removeEventListener("click",__soundPlay);
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleUpdateScore",updateScore);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHandler);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _moveOutBtn = null;
         _moveInBtn = null;
         _playerBtn = null;
         _consortiaBtn = null;
         _playerBg = null;
         _consortiaBg = null;
         _selfScoreTxt = null;
         _list = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
