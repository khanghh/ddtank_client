package farm.viewx.poultry
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.chatBall.ChatBallPlayer;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FarmPoultryInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import road.game.resource.ActionMovie;
   import room.RoomManager;
   import roomList.RoomListEnumerate;
   
   public class FarmPoultry extends Sprite implements Disposeable
   {
       
      
      private var _poultry:ActionMovie;
      
      private var _poultryName:FilterFrameText;
      
      private var _expSprite:Sprite;
      
      private var _bloodBg:Bitmap;
      
      private var _blood:Bitmap;
      
      private var _wakeFeed:WakeFeedCountDown;
      
      private var _mask:Sprite;
      
      private var _poultryArea:Sprite;
      
      private var _expText:FilterFrameText;
      
      private var _fightBossFlag:Boolean;
      
      private var _sward:MovieClip;
      
      private var _pointArray:Array;
      
      private var _pointId:int = 0;
      
      private var _walkTimer:Timer;
      
      private var _offPoint:Point;
      
      private var _moveSpeed:int = 5;
      
      private var _last_creat:uint;
      
      private var _chatBallView:ChatBallPlayer;
      
      public function FarmPoultry()
      {
         _pointArray = [new Point(224,441),new Point(349,533),new Point(465,261)];
         super();
      }
      
      public function startLoadPoultry() : void
      {
         loadPoultry();
      }
      
      private function initView() : void
      {
         var movieClass:* = null;
         movieClass = ModuleLoader.getDefinition("game.living.Living380") as Class;
         _poultry = new movieClass();
         PositionUtils.setPos(_poultry,"asset.farm.poultry.poultryPos");
         addChild(_poultry);
         _poultry.stop();
         _expSprite = new Sprite();
         PositionUtils.setPos(_expSprite,"asset.farm.poultry.expPos");
         addChild(_expSprite);
         _poultryName = ComponentFactory.Instance.creatComponentByStylename("farm.poultry.name");
         _expSprite.addChild(_poultryName);
         _bloodBg = ComponentFactory.Instance.creat("asset.farm.poultry.bloodBg");
         _expSprite.addChild(_bloodBg);
         _blood = ComponentFactory.Instance.creat("asset.farm.poultry.blood");
         _expSprite.addChild(_blood);
         _expText = ComponentFactory.Instance.creatComponentByStylename("farm.tree.treeExpTxt");
         _expText.width = _blood.bitmapData.width;
         PositionUtils.setPos(_expText,"asset.farm.poultry.expTextPos");
         _expSprite.addChild(_expText);
         _expSprite.visible = false;
         _wakeFeed = new WakeFeedCountDown();
         _wakeFeed.visible = false;
         _sward = ComponentFactory.Instance.creat("asset.farm.overEnemySword");
         addChild(_sward);
         _sward.visible = false;
         creatMask();
         creatTimer();
      }
      
      private function creatChatBall() : void
      {
         deleteChatBallView();
         _chatBallView = new ChatBallPlayer();
         PositionUtils.setPos(_chatBallView,"asset.farm.poultry.chatBallPos");
         addChild(_chatBallView);
         _chatBallView.setText(LanguageMgr.GetTranslation("farm.farmPoultry.chatBallText"));
      }
      
      private function creatTimer() : void
      {
         _walkTimer = new Timer(2000,1);
         _walkTimer.addEventListener("timer",__onPoultryWalk);
      }
      
      private function creatMask() : void
      {
         _mask = new Sprite();
         _mask.graphics.beginFill(0,0);
         _mask.graphics.drawRect(0,0,_blood.bitmapData.width,_blood.bitmapData.height);
         _mask.graphics.endFill();
         PositionUtils.setPos(_mask,_blood);
         _blood.mask = _mask;
         _expSprite.addChild(_mask);
      }
      
      private function initEvent() : void
      {
         RoomManager.Instance.addEventListener("gameRoomCreate",__gameStart);
      }
      
      public function setInfo(currentExp:int, poultryId:int, state:int, countDownTime:Date) : void
      {
         var poultryInfo:* = null;
         FarmModelController.instance.model.PoultryState = state;
         initPoultryInfo();
         if(state == 0)
         {
            this.visible = false;
            PositionUtils.setPos(this,"asset.farm.poultryPos");
         }
         else if(state == 1)
         {
            this.visible = true;
            PositionUtils.setPos(this,"asset.farm.poultryPos");
            FarmModelController.instance.dispatchEvent(new FarmEvent("farmPoultry_setCallBtn"));
            var _loc6_:* = false;
            _poultryName.visible = _loc6_;
            _loc6_ = _loc6_;
            _expText.visible = _loc6_;
            _loc6_ = _loc6_;
            _blood.visible = _loc6_;
            _bloodBg.visible = _loc6_;
            _poultry.gotoAndStop("standB");
            _loc6_ = 1;
            _poultry.scaleY = _loc6_;
            _poultry.scaleX = _loc6_;
            if(PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId || PlayerManager.Instance.Self.SpouseID == FarmModelController.instance.model.currentFarmerId)
            {
               setWakeFeedBtnState(1);
               creatPoultryArea(1,90,150);
               if(PlayerManager.Instance.Self.SpouseID == FarmModelController.instance.model.currentFarmerId)
               {
                  _wakeFeed.tipData = LanguageMgr.GetTranslation("farm.poultry.wakefeedTipTxt3");
               }
            }
         }
         else
         {
            this.visible = true;
            FarmModelController.instance.dispatchEvent(new FarmEvent("farmPoultry_setCallBtn"));
            poultryInfo = FarmModelController.instance.model.farmPoultryInfo[poultryId];
            _loc6_ = true;
            _poultryName.visible = _loc6_;
            _loc6_ = _loc6_;
            _expText.visible = _loc6_;
            _loc6_ = _loc6_;
            _blood.visible = _loc6_;
            _bloodBg.visible = _loc6_;
            _walkTimer.start();
            _poultry.gotoAndPlay("walkA");
            _poultry.scaleX = this.x < _pointArray[_pointId].x?-0.7:0.7;
            _poultry.scaleY = 0.7;
            _expText.text = currentExp + "/" + poultryInfo.MonsterExp;
            _poultryName.text = poultryInfo.MonsterName;
            setExp(currentExp,poultryInfo.MonsterExp);
            setWakeFeedBtnState(2);
            if(currentExp >= poultryInfo.MonsterExp)
            {
               _fightBossFlag = true;
               _wakeFeed.visible = false;
            }
            else
            {
               _wakeFeed.setCountDownTime(countDownTime);
            }
            creatPoultryArea(2,150,172);
         }
      }
      
      private function initPoultryInfo() : void
      {
         _fightBossFlag = false;
         _walkTimer.stop();
         _walkTimer.reset();
         deletePoultryArea();
         removeEventListener("enterFrame",__onEnterFrame);
      }
      
      private function setExp(currentExp:int, totalExp:int) : void
      {
         _expText.text = currentExp + "/" + totalExp;
         var offLen:int = _mask.width - (totalExp != 0?currentExp * _mask.width / totalExp:0);
         _mask.x = _blood.x - offLen;
      }
      
      private function setWakeFeedBtnState(id:int) : void
      {
         _wakeFeed.setFrame(id);
         PositionUtils.setPos(_wakeFeed,"farm.poultry.wakefeedBtnPos" + id);
         _wakeFeed.tipData = LanguageMgr.GetTranslation("farm.poultry.wakefeedTipTxt" + id);
      }
      
      protected function __onPoultryWalk(event:TimerEvent) : void
      {
         _poultry.scaleX = this.x < _pointArray[_pointId].x?-0.7:0.7;
         _poultry.scaleY = 0.7;
         _offPoint = new Point(_pointArray[_pointId].x - this.x,_pointArray[_pointId].y - this.y);
         _offPoint.normalize(_moveSpeed);
         addEventListener("enterFrame",__onEnterFrame);
         if(_pointId == 0)
         {
            creatChatBall();
         }
      }
      
      protected function __onEnterFrame(event:Event) : void
      {
         var len:int = Point.distance(new Point(this.x,this.y),_pointArray[_pointId]);
         if(len <= _moveSpeed)
         {
            removeEventListener("enterFrame",__onEnterFrame);
            _walkTimer.start();
            _pointId = Number(_pointId) + 1;
            if(_pointId >= _pointArray.length)
            {
               _pointId = 0;
            }
            _offPoint = null;
         }
         else
         {
            this.x = this.x + _offPoint.x;
            this.y = this.y + _offPoint.y;
         }
      }
      
      private function loadPoultry() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solvePath("image/game/living/living380.swf"),4);
         loader.addEventListener("complete",__onLoadComplete);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      protected function __onLoadComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.loader;
         loader.removeEventListener("complete",__onLoadComplete);
         initView();
         initEvent();
         this.dispatchEvent(new Event("complete"));
      }
      
      private function creatPoultryArea(id:int, width:int, height:int) : void
      {
         if(!_poultryArea)
         {
            _poultryArea = new Sprite();
         }
         _poultryArea.graphics.beginFill(0,0);
         _poultryArea.graphics.drawRect(0,0,width,height);
         _poultryArea.graphics.endFill();
         PositionUtils.setPos(_poultryArea,"asset.farm.poultryAreaPos" + id);
         _poultryArea.addEventListener("mouseOver",__onAreaOver);
         _poultryArea.addEventListener("mouseOut",__onAreaOut);
         _poultryArea.addEventListener("click",__onAreaClick);
         _poultryArea.buttonMode = true;
         _poultryArea.addChild(_wakeFeed);
         addChild(_poultryArea);
      }
      
      protected function __onAreaClick(event:MouseEvent) : void
      {
         if(_fightBossFlag)
         {
            if(getTimer() - _last_creat >= 2000)
            {
               _last_creat = getTimer();
               if(FarmModelController.instance.model.PoultryState == 3)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.farmPoultry.fightTipsTxt"));
               }
               else if(PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId)
               {
                  FarmModelController.instance.FightPoultryFlag = true;
                  GameInSocketOut.sendCreateRoom(RoomListEnumerate.PREWORD[1],28,3,"");
               }
            }
         }
      }
      
      protected function __gameStart(event:CrazyTankSocketEvent) : void
      {
         SocketManager.Instance.out.enterUserGuide(70002,28);
      }
      
      protected function __onAreaMove(event:MouseEvent) : void
      {
         _sward.x = mouseX;
         _sward.y = mouseY;
      }
      
      protected function __onAreaOut(event:MouseEvent) : void
      {
         if(FarmModelController.instance.model.PoultryState == 1)
         {
            _poultry.gotoAndPlay("standB");
         }
         else
         {
            if(_offPoint)
            {
               addEventListener("enterFrame",__onEnterFrame);
            }
            else
            {
               _walkTimer.start();
            }
            _poultry.gotoAndStop("walkA");
         }
         _expSprite.visible = false;
         if(_fightBossFlag)
         {
            if(PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId)
            {
               Mouse.show();
               _poultryArea.removeEventListener("mouseMove",__onAreaMove);
               _sward.visible = false;
            }
         }
         else
         {
            _wakeFeed.visible = false;
         }
      }
      
      protected function __onAreaOver(event:MouseEvent) : void
      {
         if(FarmModelController.instance.model.PoultryState == 1)
         {
            _poultry.gotoAndPlay("standB");
         }
         else
         {
            if(_walkTimer.running)
            {
               _walkTimer.stop();
               _walkTimer.reset();
            }
            removeEventListener("enterFrame",__onEnterFrame);
            _poultry.gotoAndPlay("walkA");
         }
         _expSprite.visible = true;
         if(_fightBossFlag)
         {
            if(PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId)
            {
               _poultryArea.addEventListener("mouseMove",__onAreaMove);
               _sward.visible = true;
               Mouse.hide();
            }
         }
         else
         {
            _wakeFeed.visible = true;
         }
      }
      
      private function deletePoultryArea() : void
      {
         if(_poultryArea)
         {
            _poultryArea.removeEventListener("mouseOver",__onAreaOver);
            _poultryArea.removeEventListener("mouseOut",__onAreaOut);
            _poultryArea.removeEventListener("click",__onAreaClick);
            ObjectUtils.removeChildAllChildren(_poultryArea);
            _poultryArea.graphics.clear();
            _poultryArea = null;
         }
      }
      
      private function deleteChatBallView() : void
      {
         if(_chatBallView)
         {
            _chatBallView.clear();
            if(_chatBallView.parent)
            {
               _chatBallView.parent.removeChild(_chatBallView);
            }
            _chatBallView.dispose();
         }
         _chatBallView = null;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__onEnterFrame);
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_walkTimer)
         {
            _walkTimer.removeEventListener("timer",__onPoultryWalk);
            _walkTimer.stop();
            _walkTimer.reset();
            _walkTimer = null;
         }
         if(_poultry)
         {
            _poultry.dispose();
            _poultry = null;
         }
         if(_bloodBg)
         {
            _bloodBg.bitmapData.dispose();
            _bloodBg = null;
         }
         if(_blood)
         {
            _blood.bitmapData.dispose();
            _blood = null;
         }
         if(_wakeFeed)
         {
            _wakeFeed.dispose();
            _wakeFeed = null;
         }
         if(_poultryName)
         {
            _poultryName.dispose();
            _poultryName = null;
         }
         if(_expText)
         {
            _expText.dispose();
            _expText = null;
         }
         if(_sward)
         {
            ObjectUtils.removeChildAllChildren(_sward);
            _sward = null;
         }
         if(_expSprite)
         {
            ObjectUtils.removeChildAllChildren(_expSprite);
            _expSprite = null;
         }
         deletePoultryArea();
         deleteChatBallView();
         if(this.parent)
         {
            ObjectUtils.removeChildAllChildren(this);
            this.parent.removeChild(this);
         }
      }
   }
}
