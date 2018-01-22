package kingDivision.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kingDivision.KingDivisionManager;
   import kingDivision.data.KingDivisionConsortionItemInfo;
   
   public class RankingRoundView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _winBg:Bitmap;
      
      private var _proBar:ProgressBarView;
      
      private var _points:FilterFrameText;
      
      private var _awardsBtn:BaseButton;
      
      private var _numberImg:Bitmap;
      
      private var _numberTxt:FilterFrameText;
      
      private var _startBtn:SimpleBitmapButton;
      
      private var _cancelBtn:SimpleBitmapButton;
      
      private var _cup:Bitmap;
      
      private var _base:Bitmap;
      
      private var _info:PlayerInfo;
      
      private var _character:RoomCharacter;
      
      private var _fireWorkds:MovieClip;
      
      private var _zone:int;
      
      private var _kingImg:Bitmap;
      
      private var _kingBase:Bitmap;
      
      private var _kingTxt:GradientText;
      
      private var _items:Vector.<KingCell>;
      
      private var _itemsEight:Vector.<KingCell>;
      
      private var _itemsFour:Vector.<KingCell>;
      
      private var _itemsTwo:Vector.<KingCell>;
      
      private var _blind:Bitmap;
      
      private var _match:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _timerUpdate:Timer;
      
      private var eliminateInfo:Vector.<KingDivisionConsortionItemInfo>;
      
      private var eliminateAllZoneInfo:Vector.<KingDivisionConsortionItemInfo>;
      
      private var isWin:Boolean;
      
      private var index:int = 0;
      
      private var isConsortiaID:Boolean;
      
      private var _areaStyle:String;
      
      private var _areaSex:Boolean;
      
      private var _areaConsortionName:String;
      
      private var isCheckTime:Boolean;
      
      public function RankingRoundView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.kingdivision.16gameframe");
         _winBg = ComponentFactory.Instance.creatBitmap("asset.kingdivision.winframe");
         _winBg.visible = false;
         _points = ComponentFactory.Instance.creatComponentByStylename("rankingRoundView.pointsTxt");
         _points.text = KingDivisionManager.Instance.points.toString();
         _awardsBtn = ComponentFactory.Instance.creat("rankingRoundView.awardsBtn");
         _numberImg = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.number");
         _numberTxt = ComponentFactory.Instance.creatComponentByStylename("rankingRoundView.numberTxt");
         _numberTxt.text = KingDivisionManager.Instance.gameNum.toString();
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("rankingRoundView.startBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("rankingRoundView.cancelBtn");
         _cancelBtn.visible = false;
         _cup = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.cup");
         _base = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.base");
         _blind = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.blind");
         _blind.visible = false;
         _match = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.match");
         _match.visible = false;
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.rankingRoundView.timeTxt");
         addChild(_bg);
         addChild(_winBg);
         addChild(_points);
         addChild(_awardsBtn);
         addChild(_numberImg);
         addChild(_numberTxt);
         addChild(_startBtn);
         addChild(_cancelBtn);
         addChild(_base);
         addChild(_cup);
         addChild(_blind);
         addChild(_match);
         addChild(_timeTxt);
         createCell(1,16);
         createCell(2,8);
         createCell(3,4);
         createCell(4,2);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timer);
         _timerUpdate = new Timer(60000);
         _timerUpdate.addEventListener("timer",__updateConsortionMessage);
         _timerUpdate.start();
         playerIsConsortion();
         checkGameStartTimer();
      }
      
      private function addEvent() : void
      {
         _awardsBtn.addEventListener("click",__onClickAwardsBtn);
         _startBtn.addEventListener("click",__onStartBtnClick);
         _cancelBtn.addEventListener("click",__onCancelBtnClick);
      }
      
      private function removeEvent() : void
      {
         _awardsBtn.removeEventListener("click",__onClickAwardsBtn);
         _startBtn.removeEventListener("click",__onStartBtnClick);
         _cancelBtn.removeEventListener("click",__onCancelBtnClick);
         _timer.removeEventListener("timer",__timer);
         _timerUpdate.removeEventListener("timer",__updateConsortionMessage);
      }
      
      private function __onStartBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _timerUpdate.stop();
         if(!KingDivisionManager.Instance.checkGameTimeIsOpen())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.kingdivision.checkGameTimesIsOpen"));
            return;
         }
         if(KingDivisionManager.Instance.gameNum <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.kingdivision.gameNum"));
            return;
         }
         if(PlayerManager.Instance.Self.Grade < KingDivisionManager.Instance.level)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.kingdivision.gameLevel",KingDivisionManager.Instance.level));
            return;
         }
         if(KingDivisionManager.Instance.checkCanStartGame())
         {
            startGame();
         }
      }
      
      private function startGame() : void
      {
         var _loc1_:int = 0;
         if(KingDivisionManager.Instance.states == 1)
         {
            _loc1_ = 3;
         }
         else if(KingDivisionManager.Instance.states == 2)
         {
            _loc1_ = 4;
         }
         GameInSocketOut.sendKingDivisionGameStart(_loc1_);
      }
      
      private function __onCancelBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         cancelMatch();
      }
      
      public function cancelMatch() : void
      {
         _timerUpdate.start();
         _startBtn.visible = true;
         _awardsBtn.mouseEnabled = true;
         _cancelBtn.visible = false;
         _blind.visible = false;
         _match.visible = false;
         _timeTxt.text = "";
         _timer.stop();
         _timer.reset();
         GameInSocketOut.sendCancelWait();
      }
      
      private function playerIsConsortion() : void
      {
         if(PlayerManager.Instance.Self.ConsortiaID <= 0)
         {
            _startBtn.visible = false;
            _cancelBtn.visible = false;
            _blind.visible = false;
            _match.visible = false;
            if(_numberImg)
            {
               ObjectUtils.disposeObject(_numberImg);
               _numberImg = null;
            }
            if(_numberTxt)
            {
               ObjectUtils.disposeObject(_numberTxt);
               _numberTxt = null;
            }
            return;
         }
         _startBtn.visible = true;
      }
      
      public function updateMessage(param1:int, param2:int) : void
      {
         _points.text = param1.toString();
         _numberTxt.text = param2.toString();
      }
      
      private function __timer(param1:TimerEvent) : void
      {
         var _loc2_:uint = _timer.currentCount / 60;
         var _loc3_:uint = _timer.currentCount % 60;
         _timeTxt.text = _loc3_ > 9?_loc3_.toString():"0" + _loc3_;
      }
      
      public function updateButtons() : void
      {
         _startBtn.visible = false;
         _awardsBtn.mouseEnabled = false;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
            _cancelBtn = null;
         }
         if(_blind)
         {
            ObjectUtils.disposeObject(_blind);
            _blind = null;
         }
         if(_match)
         {
            ObjectUtils.disposeObject(_match);
            _match = null;
         }
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("rankingRoundView.cancelBtn");
         _cancelBtn.addEventListener("click",__onCancelBtnClick);
         _cancelBtn.visible = true;
         _blind = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.blind");
         _blind.visible = true;
         _match = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.match");
         _match.visible = true;
         addChild(_blind);
         addChild(_match);
         addChild(_cancelBtn);
         if(_timer && !_timer.running)
         {
            if(_timeTxt)
            {
               ObjectUtils.disposeObject(_timeTxt);
               _timeTxt = null;
            }
            _timeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.rankingRoundView.timeTxt");
            _timeTxt.text = "00";
            addChild(_timeTxt);
            _timer.start();
         }
      }
      
      private function createCell(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(param1 == 1)
         {
            _items = new Vector.<KingCell>(1);
         }
         else if(param1 == 2)
         {
            _itemsEight = new Vector.<KingCell>(1);
         }
         else if(param1 == 3)
         {
            _itemsFour = new Vector.<KingCell>(1);
         }
         else if(param1 == 4)
         {
            _itemsTwo = new Vector.<KingCell>(1);
         }
         _loc4_ = 1;
         while(_loc4_ <= param2)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("kingdivision.rankingRoundView." + param1 + "." + _loc4_);
            _loc3_.mouseEnabled = true;
            _loc3_.index = param1;
            addChild(_loc3_);
            if(param1 == 1)
            {
               _items.push(_loc3_);
            }
            else if(param1 == 2)
            {
               _itemsEight.push(_loc3_);
            }
            else if(param1 == 3)
            {
               _itemsFour.push(_loc3_);
            }
            else if(param1 == 4)
            {
               _itemsTwo.push(_loc3_);
            }
            _loc4_++;
         }
      }
      
      public function set progressBarView(param1:ProgressBarView) : void
      {
         _proBar = param1;
      }
      
      public function set zone(param1:int) : void
      {
         _zone = param1;
         updateCell();
      }
      
      private function updateCell() : void
      {
         if(_zone == 0)
         {
            eliminateInfo = KingDivisionManager.Instance.model.eliminateInfo;
            promotion(eliminateInfo);
         }
         else if(_zone == 1)
         {
            eliminateAllZoneInfo = KingDivisionManager.Instance.model.eliminateAllZoneInfo;
            promotion(eliminateAllZoneInfo);
         }
      }
      
      private function promotion(param1:Vector.<KingDivisionConsortionItemInfo>) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc4_:Array = KingDivisionManager.Instance.dateArr;
         var _loc2_:Array = KingDivisionManager.Instance.allDateArr;
         if(_zone == 0)
         {
            topSixteen(param1);
            if(_loc4_[1] <= _loc3_.date)
            {
               promotionGuild(_items,_itemsEight,1,9,16);
            }
            if(_loc4_[2] <= _loc3_.date)
            {
               promotionGuild(_itemsEight,_itemsFour,2,5,8);
            }
            if(_loc4_[3] <= _loc3_.date)
            {
               promotionGuild(_itemsFour,_itemsTwo,3,3,4);
            }
            if(_loc4_[4] <= _loc3_.date)
            {
               topOne();
            }
         }
         else if(_zone == 1)
         {
            topSixteenArea(param1);
            if(_loc2_[1] <= _loc3_.date)
            {
               promotionGuildArea(_items,_itemsEight,1,9,16);
            }
            if(_loc2_[1] <= _loc3_.date)
            {
               promotionGuildArea(_itemsEight,_itemsFour,2,5,8);
            }
            if(_loc2_[1] <= _loc3_.date)
            {
               promotionGuildArea(_itemsFour,_itemsTwo,3,3,4);
            }
            if(_loc2_[1] <= _loc3_.date)
            {
               topOneArea();
            }
         }
         if(_cup)
         {
            ObjectUtils.disposeObject(_cup);
            _cup = null;
         }
         if(_base)
         {
            ObjectUtils.disposeObject(_base);
            _base = null;
         }
         _cup = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.cup");
         _base = ComponentFactory.Instance.creatBitmap("asset.rankingRoundView.base");
         addChild(_base);
         addChild(_cup);
         if(isWin)
         {
            championMC();
         }
         if(!isConsortiaID)
         {
            rankNoMeConsortion();
         }
      }
      
      private function topSixteen(param1:Vector.<KingDivisionConsortionItemInfo>) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         index = 0;
         _loc2_ = 1;
         while(_loc2_ <= 16)
         {
            if(index < param1.length)
            {
               if(param1[index].conState >= 0)
               {
                  if(isConsortiaID || _loc2_ <= param1.length && PlayerManager.Instance.Self.ConsortiaID == param1[_loc2_ - 1].conID && param1[_loc2_ - 1].isGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(_loc2_ % 2 != 0)
                  {
                     if(index < 4)
                     {
                        _items[_loc2_].setNickName(param1[index],"right");
                     }
                     else
                     {
                        _items[_loc2_].setNickName(param1[index]);
                     }
                     index = Number(index) + 1;
                  }
                  else if(index + 7 < param1.length)
                  {
                     if(index + 7 < 12)
                     {
                        _items[_loc2_].setNickName(param1[index + 7],"right");
                     }
                     else
                     {
                        _items[_loc2_].setNickName(param1[index + 7]);
                     }
                  }
               }
               _loc2_++;
               continue;
            }
            break;
         }
      }
      
      private function topSixteenArea(param1:Vector.<KingDivisionConsortionItemInfo>) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         index = 0;
         _loc2_ = 1;
         while(_loc2_ <= 16)
         {
            if(index < param1.length)
            {
               if(param1[index].consortionState >= 0)
               {
                  if(isConsortiaID || _loc2_ <= param1.length && PlayerManager.Instance.Self.ConsortiaID == param1[_loc2_ - 1].consortionIDArea && param1[_loc2_ - 1].consortionIsGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(_loc2_ % 2 != 0)
                  {
                     if(index < 4)
                     {
                        _items[_loc2_].setNickName(param1[index],"right");
                     }
                     else
                     {
                        _items[_loc2_].setNickName(param1[index]);
                     }
                     index = Number(index) + 1;
                  }
                  else if(index + 7 < param1.length)
                  {
                     if(index + 7 < 12)
                     {
                        _items[_loc2_].setNickName(param1[index + 7],"right");
                     }
                     else
                     {
                        _items[_loc2_].setNickName(param1[index + 7]);
                     }
                  }
               }
               _loc2_++;
               continue;
            }
            break;
         }
      }
      
      private function promotionGuild(param1:Vector.<KingCell>, param2:Vector.<KingCell>, param3:int, param4:int, param5:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         index = 1;
         _loc7_ = 1;
         while(_loc7_ < param1.length)
         {
            if(param1[_loc7_]._playerInfo != null)
            {
               if(param1[_loc7_]._playerInfo.conState >= param3)
               {
                  if(isConsortiaID || PlayerManager.Instance.Self.ConsortiaID == param1[_loc7_]._playerInfo.conID && param1[_loc7_]._playerInfo.isGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(_loc7_ < param4)
                  {
                     param2[index].setNickName(param1[_loc7_]._playerInfo,"right");
                  }
                  else
                  {
                     param2[index].setNickName(param1[_loc7_]._playerInfo);
                  }
                  _loc6_ = ComponentFactory.Instance.creatBitmap("asst.kingdivision." + param5 + "." + _loc7_);
                  addChild(_loc6_);
                  index = Number(index) + 1;
               }
            }
            _loc7_++;
         }
      }
      
      private function promotionGuildArea(param1:Vector.<KingCell>, param2:Vector.<KingCell>, param3:int, param4:int, param5:int) : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         index = 1;
         _loc7_ = 1;
         while(_loc7_ < param1.length)
         {
            if(param1[_loc7_]._playerInfo != null)
            {
               if(param1[_loc7_]._playerInfo.consortionState >= param3)
               {
                  if(isConsortiaID || PlayerManager.Instance.Self.ConsortiaID == param1[_loc7_]._playerInfo.consortionIDArea && PlayerManager.Instance.Self.ZoneID == param1[_loc7_]._playerInfo.areaID && param1[_loc7_]._playerInfo.consortionIsGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(_loc7_ < param4)
                  {
                     param2[index].setNickName(param1[_loc7_]._playerInfo,"right");
                  }
                  else
                  {
                     param2[index].setNickName(param1[_loc7_]._playerInfo);
                  }
                  _loc6_ = ComponentFactory.Instance.creatBitmap("asst.kingdivision." + param5 + "." + _loc7_);
                  addChild(_loc6_);
                  index = Number(index) + 1;
               }
            }
            _loc7_++;
         }
      }
      
      private function topOne() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc1_ = 1;
         while(_loc1_ < _itemsTwo.length)
         {
            if(_itemsTwo[_loc1_]._playerInfo != null)
            {
               if(_itemsTwo[_loc1_]._playerInfo.conState >= 4)
               {
                  if(KingDivisionManager.Instance.isThisZoneWin)
                  {
                     _areaStyle = _itemsTwo[_loc1_]._playerInfo.conStyle;
                     _areaSex = _itemsTwo[_loc1_]._playerInfo.conSex;
                     _areaConsortionName = _itemsTwo[_loc1_]._playerInfo.conName;
                     isWin = true;
                  }
                  else
                  {
                     KingDivisionManager.Instance.thisZoneNickName = _itemsTwo[_loc1_]._playerInfo.name;
                     isWin = true;
                  }
                  _loc2_ = ComponentFactory.Instance.creatBitmap("asst.kingdivision.2." + _loc1_);
                  addChild(_loc2_);
                  break;
               }
               _areaStyle = null;
               KingDivisionManager.Instance.thisZoneNickName = "";
            }
            _loc1_++;
         }
      }
      
      private function topOneArea() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc1_ = 1;
         while(_loc1_ < _itemsTwo.length)
         {
            if(_itemsTwo[_loc1_]._playerInfo != null)
            {
               if(_itemsTwo[_loc1_]._playerInfo.consortionState >= 4)
               {
                  _areaStyle = _itemsTwo[_loc1_]._playerInfo.consortionStyle;
                  _areaSex = _itemsTwo[_loc1_]._playerInfo.consortionSex;
                  _areaConsortionName = _itemsTwo[_loc1_]._playerInfo.consortionNameArea;
                  isWin = true;
                  _loc2_ = ComponentFactory.Instance.creatBitmap("asst.kingdivision.2." + _loc1_);
                  addChild(_loc2_);
                  break;
               }
               _areaStyle = null;
            }
            _loc1_++;
         }
      }
      
      public function setDateStages(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Date = TimeManager.Instance.Now();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == _loc2_.date)
            {
               _proBar.proBarAllMovie.gotoAndStop(_loc3_ + 1);
               break;
            }
            if(param1[_loc3_] < _loc2_.date)
            {
               _proBar.proBarAllMovie.gotoAndStop(5);
            }
            _loc3_++;
         }
      }
      
      private function __onClickAwardsBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:RewardView = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.RewardView");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function setPlayerInfo(param1:String) : void
      {
         _info = new PlayerInfo();
         if(KingDivisionManager.Instance.states == 2 && !KingDivisionManager.Instance.isThisZoneWin)
         {
            _info.Style = _areaStyle;
            _info.Sex = _areaSex;
            if(_info.Style)
            {
               updateCharacter();
            }
            return;
         }
         if(param1 == PlayerManager.Instance.Self.NickName)
         {
            _info = PlayerManager.Instance.Self;
         }
         else
         {
            _info = PlayerManager.Instance.findPlayerByNickName(_info,param1);
         }
         if(KingDivisionManager.Instance.isThisZoneWin)
         {
            _info.Style = _areaStyle;
            _info.Sex = _areaSex;
            if(_info.Style)
            {
               updateCharacter();
            }
         }
         else if(_info.ID && _info.Style)
         {
            updateCharacter();
         }
         else
         {
            SocketManager.Instance.out.sendItemEquip(param1,true);
            _info.addEventListener("propertychange",__playerInfoChange);
         }
      }
      
      private function __playerInfoChange(param1:PlayerPropertyEvent) : void
      {
         _info.removeEventListener("propertychange",__playerInfoChange);
         updateCharacter();
      }
      
      private function updateCharacter() : void
      {
         if(_info)
         {
            if(_character)
            {
               _character.dispose();
               _character = null;
            }
            _character = CharactoryFactory.createCharacter(_info,"room") as RoomCharacter;
            _character.showGun = false;
            _character.show(false,-1);
            _character.x = 466;
            _character.y = 93;
            addChild(_character);
            if(_fireWorkds == null)
            {
               _fireWorkds = ComponentFactory.Instance.creatCustomObject("asset.rankingRoundView.fireWorkds");
               addChild(_fireWorkds);
            }
            if(_kingBase == null)
            {
               _kingBase = ComponentFactory.Instance.creatBitmap("asset.kingdivision.kingbase");
               addChild(_kingBase);
            }
            if(_kingImg == null)
            {
               _kingImg = ComponentFactory.Instance.creatBitmap("asset.kingdivision.king");
               addChild(_kingImg);
            }
            if(_kingTxt == null)
            {
               _kingTxt = ComponentFactory.Instance.creatComponentByStylename("rankingRoundView.kingTxt");
               addChild(_kingTxt);
            }
            if(KingDivisionManager.Instance.states == 2 && !KingDivisionManager.Instance.isThisZoneWin)
            {
               _kingTxt.text = _areaConsortionName;
            }
            else if(KingDivisionManager.Instance.isThisZoneWin)
            {
               _kingTxt.text = _areaConsortionName;
            }
            else
            {
               _kingTxt.text = _info.ConsortiaName;
            }
         }
         else
         {
            _character.dispose();
            _character = null;
         }
      }
      
      private function championMC() : void
      {
         if(KingDivisionManager.Instance.thisZoneNickName == "" && _areaStyle == "")
         {
            _cup.visible = true;
            _startBtn.visible = true;
            _cancelBtn.visible = false;
            _winBg.visible = false;
            return;
         }
         if(_zone == 0 && (KingDivisionManager.Instance.thisZoneNickName != "" || _areaStyle != ""))
         {
            setPlayerInfo(KingDivisionManager.Instance.thisZoneNickName);
         }
         else if(_zone == 1 && _areaStyle != "")
         {
            setPlayerInfo(KingDivisionManager.Instance.allZoneNickName);
         }
         _winBg.visible = true;
         _cup.visible = false;
         _startBtn.visible = false;
         _cancelBtn.visible = false;
         _points.text = "---";
         if(_numberTxt)
         {
            _numberTxt.text = "---";
         }
      }
      
      private function rankNoMeConsortion() : void
      {
         if(_numberImg)
         {
            ObjectUtils.disposeObject(_numberImg);
            _numberImg = null;
         }
         if(_numberTxt)
         {
            ObjectUtils.disposeObject(_numberTxt);
            _numberTxt = null;
         }
         _startBtn.visible = false;
         _cancelBtn.visible = false;
         _blind.visible = false;
         _match.visible = false;
         _timeTxt.text = "";
         _timer.stop();
         _timer.reset();
      }
      
      private function __updateConsortionMessage(param1:TimerEvent) : void
      {
         if(!isCheckTime)
         {
            checkGameStartTimer();
         }
         KingDivisionManager.Instance.updateConsotionMessage();
      }
      
      private function checkGameStartTimer() : void
      {
         if(!KingDivisionManager.Instance.checkGameTimeIsOpen())
         {
            _startBtn.enable = false;
            _startBtn.mouseEnabled = false;
            _startBtn.mouseChildren = false;
         }
         else
         {
            _startBtn.enable = true;
            _startBtn.mouseEnabled = true;
            _startBtn.mouseChildren = true;
            isCheckTime = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         isCheckTime = false;
         KingDivisionManager.Instance.thisZoneNickName = "";
         ObjectUtils.disposeObject(_awardsBtn);
         _awardsBtn = null;
         ObjectUtils.disposeObject(_fireWorkds);
         _fireWorkds = null;
         ObjectUtils.disposeObject(_points);
         _points = null;
         ObjectUtils.disposeObject(_character);
         _character = null;
         ObjectUtils.disposeObject(_numberTxt);
         _numberTxt = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_kingTxt);
         _cancelBtn = null;
         ObjectUtils.disposeObject(eliminateInfo);
         eliminateInfo = null;
         ObjectUtils.disposeObject(eliminateAllZoneInfo);
         eliminateAllZoneInfo = null;
         if(_timer)
         {
            _timer.stop();
            ObjectUtils.disposeObject(_timer);
            _timer = null;
         }
         if(_timerUpdate)
         {
            _timerUpdate.stop();
            ObjectUtils.disposeObject(_timerUpdate);
            _timerUpdate = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
