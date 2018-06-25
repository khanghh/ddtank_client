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
      
      private function __onStartBtnClick(evt:MouseEvent) : void
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
         var type:int = 0;
         if(KingDivisionManager.Instance.states == 1)
         {
            type = 3;
         }
         else if(KingDivisionManager.Instance.states == 2)
         {
            type = 4;
         }
         GameInSocketOut.sendKingDivisionGameStart(type);
      }
      
      private function __onCancelBtnClick(evt:MouseEvent) : void
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
      
      public function updateMessage(score:int, gameNum:int) : void
      {
         _points.text = score.toString();
         _numberTxt.text = gameNum.toString();
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         var min:uint = _timer.currentCount / 60;
         var sec:uint = _timer.currentCount % 60;
         _timeTxt.text = sec > 9?sec.toString():"0" + sec;
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
      
      private function createCell(round:int, count:int) : void
      {
         var i:int = 0;
         var cell:* = null;
         if(round == 1)
         {
            _items = new Vector.<KingCell>(1);
         }
         else if(round == 2)
         {
            _itemsEight = new Vector.<KingCell>(1);
         }
         else if(round == 3)
         {
            _itemsFour = new Vector.<KingCell>(1);
         }
         else if(round == 4)
         {
            _itemsTwo = new Vector.<KingCell>(1);
         }
         i = 1;
         while(i <= count)
         {
            cell = ComponentFactory.Instance.creatCustomObject("kingdivision.rankingRoundView." + round + "." + i);
            cell.mouseEnabled = true;
            cell.index = round;
            addChild(cell);
            if(round == 1)
            {
               _items.push(cell);
            }
            else if(round == 2)
            {
               _itemsEight.push(cell);
            }
            else if(round == 3)
            {
               _itemsFour.push(cell);
            }
            else if(round == 4)
            {
               _itemsTwo.push(cell);
            }
            i++;
         }
      }
      
      public function set progressBarView(value:ProgressBarView) : void
      {
         _proBar = value;
      }
      
      public function set zone(value:int) : void
      {
         _zone = value;
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
      
      private function promotion(info:Vector.<KingDivisionConsortionItemInfo>) : void
      {
         if(info == null)
         {
            return;
         }
         var date:Date = TimeManager.Instance.Now();
         var dateArr:Array = KingDivisionManager.Instance.dateArr;
         var dateArrArea:Array = KingDivisionManager.Instance.allDateArr;
         if(_zone == 0)
         {
            topSixteen(info);
            if(dateArr[1] <= date.date)
            {
               promotionGuild(_items,_itemsEight,1,9,16);
            }
            if(dateArr[2] <= date.date)
            {
               promotionGuild(_itemsEight,_itemsFour,2,5,8);
            }
            if(dateArr[3] <= date.date)
            {
               promotionGuild(_itemsFour,_itemsTwo,3,3,4);
            }
            if(dateArr[4] <= date.date)
            {
               topOne();
            }
         }
         else if(_zone == 1)
         {
            topSixteenArea(info);
            if(dateArrArea[1] <= date.date)
            {
               promotionGuildArea(_items,_itemsEight,1,9,16);
            }
            if(dateArrArea[1] <= date.date)
            {
               promotionGuildArea(_itemsEight,_itemsFour,2,5,8);
            }
            if(dateArrArea[1] <= date.date)
            {
               promotionGuildArea(_itemsFour,_itemsTwo,3,3,4);
            }
            if(dateArrArea[1] <= date.date)
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
      
      private function topSixteen(eliminateInfo:Vector.<KingDivisionConsortionItemInfo>) : void
      {
         var i:int = 0;
         if(eliminateInfo == null)
         {
            return;
         }
         index = 0;
         for(i = 1; i <= 16; )
         {
            if(index < eliminateInfo.length)
            {
               if(eliminateInfo[index].conState >= 0)
               {
                  if(isConsortiaID || i <= eliminateInfo.length && PlayerManager.Instance.Self.ConsortiaID == eliminateInfo[i - 1].conID && eliminateInfo[i - 1].isGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(i % 2 != 0)
                  {
                     if(index < 4)
                     {
                        _items[i].setNickName(eliminateInfo[index],"right");
                     }
                     else
                     {
                        _items[i].setNickName(eliminateInfo[index]);
                     }
                     index = Number(index) + 1;
                  }
                  else if(index + 7 < eliminateInfo.length)
                  {
                     if(index + 7 < 12)
                     {
                        _items[i].setNickName(eliminateInfo[index + 7],"right");
                     }
                     else
                     {
                        _items[i].setNickName(eliminateInfo[index + 7]);
                     }
                  }
               }
               i++;
               continue;
            }
            break;
         }
      }
      
      private function topSixteenArea(info:Vector.<KingDivisionConsortionItemInfo>) : void
      {
         var i:int = 0;
         if(info == null)
         {
            return;
         }
         index = 0;
         for(i = 1; i <= 16; )
         {
            if(index < info.length)
            {
               if(info[index].consortionState >= 0)
               {
                  if(isConsortiaID || i <= info.length && PlayerManager.Instance.Self.ConsortiaID == info[i - 1].consortionIDArea && info[i - 1].consortionIsGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(i % 2 != 0)
                  {
                     if(index < 4)
                     {
                        _items[i].setNickName(info[index],"right");
                     }
                     else
                     {
                        _items[i].setNickName(info[index]);
                     }
                     index = Number(index) + 1;
                  }
                  else if(index + 7 < info.length)
                  {
                     if(index + 7 < 12)
                     {
                        _items[i].setNickName(info[index + 7],"right");
                     }
                     else
                     {
                        _items[i].setNickName(info[index + 7]);
                     }
                  }
               }
               i++;
               continue;
            }
            break;
         }
      }
      
      private function promotionGuild(cell:Vector.<KingCell>, proCell:Vector.<KingCell>, state:int, num:int, linkName:int) : void
      {
         var i:int = 0;
         var bitMap:* = null;
         index = 1;
         for(i = 1; i < cell.length; )
         {
            if(cell[i]._playerInfo != null)
            {
               if(cell[i]._playerInfo.conState >= state)
               {
                  if(isConsortiaID || PlayerManager.Instance.Self.ConsortiaID == cell[i]._playerInfo.conID && cell[i]._playerInfo.isGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(i < num)
                  {
                     proCell[index].setNickName(cell[i]._playerInfo,"right");
                  }
                  else
                  {
                     proCell[index].setNickName(cell[i]._playerInfo);
                  }
                  bitMap = ComponentFactory.Instance.creatBitmap("asst.kingdivision." + linkName + "." + i);
                  addChild(bitMap);
                  index = Number(index) + 1;
               }
            }
            i++;
         }
      }
      
      private function promotionGuildArea(cell:Vector.<KingCell>, proCell:Vector.<KingCell>, state:int, num:int, linkName:int) : void
      {
         var i:int = 0;
         var bitMap:* = null;
         index = 1;
         for(i = 1; i < cell.length; )
         {
            if(cell[i]._playerInfo != null)
            {
               if(cell[i]._playerInfo.consortionState >= state)
               {
                  if(isConsortiaID || PlayerManager.Instance.Self.ConsortiaID == cell[i]._playerInfo.consortionIDArea && PlayerManager.Instance.Self.ZoneID == cell[i]._playerInfo.areaID && cell[i]._playerInfo.consortionIsGame)
                  {
                     isConsortiaID = true;
                  }
                  else
                  {
                     isConsortiaID = false;
                  }
                  if(i < num)
                  {
                     proCell[index].setNickName(cell[i]._playerInfo,"right");
                  }
                  else
                  {
                     proCell[index].setNickName(cell[i]._playerInfo);
                  }
                  bitMap = ComponentFactory.Instance.creatBitmap("asst.kingdivision." + linkName + "." + i);
                  addChild(bitMap);
                  index = Number(index) + 1;
               }
            }
            i++;
         }
      }
      
      private function topOne() : void
      {
         var t:int = 0;
         var bitMap:* = null;
         for(t = 1; t < _itemsTwo.length; )
         {
            if(_itemsTwo[t]._playerInfo != null)
            {
               if(_itemsTwo[t]._playerInfo.conState >= 4)
               {
                  if(KingDivisionManager.Instance.isThisZoneWin)
                  {
                     _areaStyle = _itemsTwo[t]._playerInfo.conStyle;
                     _areaSex = _itemsTwo[t]._playerInfo.conSex;
                     _areaConsortionName = _itemsTwo[t]._playerInfo.conName;
                     isWin = true;
                  }
                  else
                  {
                     KingDivisionManager.Instance.thisZoneNickName = _itemsTwo[t]._playerInfo.name;
                     isWin = true;
                  }
                  bitMap = ComponentFactory.Instance.creatBitmap("asst.kingdivision.2." + t);
                  addChild(bitMap);
                  break;
               }
               _areaStyle = null;
               KingDivisionManager.Instance.thisZoneNickName = "";
            }
            t++;
         }
      }
      
      private function topOneArea() : void
      {
         var t:int = 0;
         var bitMap:* = null;
         for(t = 1; t < _itemsTwo.length; )
         {
            if(_itemsTwo[t]._playerInfo != null)
            {
               if(_itemsTwo[t]._playerInfo.consortionState >= 4)
               {
                  _areaStyle = _itemsTwo[t]._playerInfo.consortionStyle;
                  _areaSex = _itemsTwo[t]._playerInfo.consortionSex;
                  _areaConsortionName = _itemsTwo[t]._playerInfo.consortionNameArea;
                  isWin = true;
                  bitMap = ComponentFactory.Instance.creatBitmap("asst.kingdivision.2." + t);
                  addChild(bitMap);
                  break;
               }
               _areaStyle = null;
            }
            t++;
         }
      }
      
      public function setDateStages(arr:Array) : void
      {
         var i:int = 0;
         var date:Date = TimeManager.Instance.Now();
         for(i = 0; i < arr.length; )
         {
            if(arr[i] == date.date)
            {
               _proBar.proBarAllMovie.gotoAndStop(i + 1);
               break;
            }
            if(arr[i] < date.date)
            {
               _proBar.proBarAllMovie.gotoAndStop(5);
            }
            i++;
         }
      }
      
      private function __onClickAwardsBtn(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var rewView:RewardView = ComponentFactory.Instance.creatComponentByStylename("qualificationsFrame.RewardView");
         LayerManager.Instance.addToLayer(rewView,3,true,1);
      }
      
      private function setPlayerInfo(nickName:String) : void
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
         if(nickName == PlayerManager.Instance.Self.NickName)
         {
            _info = PlayerManager.Instance.Self;
         }
         else
         {
            _info = PlayerManager.Instance.findPlayerByNickName(_info,nickName);
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
            SocketManager.Instance.out.sendItemEquip(nickName,true);
            _info.addEventListener("propertychange",__playerInfoChange);
         }
      }
      
      private function __playerInfoChange(event:PlayerPropertyEvent) : void
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
      
      private function __updateConsortionMessage(evt:TimerEvent) : void
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
