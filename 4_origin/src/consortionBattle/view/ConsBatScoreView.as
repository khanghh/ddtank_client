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
      
      private function updateScore(event:ConsBatEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var tmp:* = null;
         var k:int = 0;
         var count2:int = 0;
         var j:int = 0;
         var tmp2:* = null;
         var pkg:PackageIn = event.data as PackageIn;
         var type:int = pkg.readByte();
         if(type == 1)
         {
            _consortiaScoreList = [];
            count = pkg.readInt();
            for(i = 0; i < count; )
            {
               tmp = {};
               tmp.name = pkg.readUTF();
               tmp.rank = pkg.readInt();
               tmp.score = pkg.readInt();
               _consortiaScoreList.push(tmp);
               i++;
            }
            _consortiaScoreList.sortOn("score",16 | 2);
            for(k = 0; k < count; )
            {
               _consortiaScoreList[k].rank = k + 1;
               k++;
            }
         }
         else
         {
            _playerScoreList = [];
            count2 = pkg.readInt();
            for(j = 0; j < count2; )
            {
               tmp2 = {};
               tmp2.name = pkg.readUTF();
               tmp2.rank = pkg.readInt();
               tmp2.score = pkg.readInt();
               _playerScoreList.push(tmp2);
               j++;
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
      
      private function __changeHandler(event:Event) : void
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
      
      private function timerHandler(event:Event) : void
      {
         var tmp:int = 0;
         if(_btnGroup.selectIndex == 0)
         {
            tmp = 1;
         }
         else
         {
            tmp = 2;
         }
         SocketManager.Instance.out.sendConsBatUpdateScore(tmp);
      }
      
      private function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         setInOutVisible(false);
         TweenLite.to(this,0.5,{"x":999});
      }
      
      private function setInOutVisible(isOut:Boolean) : void
      {
         _moveOutBtn.visible = isOut;
         _moveInBtn.visible = !isOut;
      }
      
      private function inHandler(event:MouseEvent) : void
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
