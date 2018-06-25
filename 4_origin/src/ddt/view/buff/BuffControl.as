package ddt.view.buff
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.data.GourdExpBottleInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.buff.buffButton.BuffButton;
   import ddt.view.buff.buffButton.GourdExpBottleButton;
   import ddt.view.buff.buffButton.GrowHelpBuffButton;
   import ddt.view.buff.buffButton.LabyrinthBuffButton;
   import ddt.view.buff.buffButton.PayBuffButton;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import oldplayergetticket.GetTicketManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import trainer.view.NewHandContainer;
   
   public class BuffControl extends Sprite implements Disposeable
   {
       
      
      private var _buffData:DictionaryData;
      
      private var _buffList:HBox;
      
      private var _buffBtnArr:Array;
      
      private var _str:String;
      
      private var _spacing:int;
      
      private var _growHelpBuff:GrowHelpBuffButton;
      
      private var _payBuff:PayBuffButton;
      
      private var _labyrinthBuff:LabyrinthBuffButton;
      
      private var _expBlessedIcon:ScaleFrameImage;
      
      private var _getTicketBtn:BaseButton;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _gourdExpBottle:GourdExpBottleButton;
      
      public function BuffControl(str:String = "", spacing:int = 0)
      {
         super();
         _spacing = spacing;
         _str = str;
         init();
         initEvents();
      }
      
      public static function isPayBuff(buffInfo:BuffInfo) : Boolean
      {
         var _loc2_:* = buffInfo.Type;
         if(70 !== _loc2_)
         {
            if(51 !== _loc2_)
            {
               if(50 !== _loc2_)
               {
                  if(52 !== _loc2_)
                  {
                     if(71 !== _loc2_)
                     {
                        if(72 !== _loc2_)
                        {
                           if(73 !== _loc2_)
                           {
                              return false;
                           }
                        }
                        addr16:
                        return true;
                     }
                     addr15:
                     §§goto(addr16);
                  }
                  addr14:
                  §§goto(addr15);
               }
               addr13:
               §§goto(addr14);
            }
            addr12:
            §§goto(addr13);
         }
         §§goto(addr12);
      }
      
      private function init() : void
      {
         _buffData = PlayerManager.Instance.Self.buffInfo;
         _buffList = new HBox();
         _buffList.spacing = _spacing;
         addChild(_buffList);
         initBuffButtons();
      }
      
      public function set boxSpacing(value:int) : void
      {
         _buffList.spacing = value;
      }
      
      private function initEvents() : void
      {
         _buffData.addEventListener("add",__addBuff);
         _buffData.addEventListener("remove",__removeBuff);
         _buffData.addEventListener("update",__addBuff);
         PlayerManager.Instance.Self.addEventListener("propertychange",addGourdExpBottleBuffEvent);
      }
      
      protected function addGourdExpBottleBuffEvent(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"])
         {
            if(PlayerManager.Instance.Self.Grade >= 30)
            {
               SocketManager.Instance.addEventListener(PkgEvent.format(393),__addGourdExpBottleButton);
               SocketManager.Instance.out.sendStopExpStorage(1);
               PlayerManager.Instance.Self.removeEventListener("propertychange",addGourdExpBottleBuffEvent);
            }
         }
      }
      
      private function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(149,8),__addGetTicketBtn);
         if(_buffData)
         {
            _buffData.removeEventListener("add",__addBuff);
            _buffData.removeEventListener("remove",__removeBuff);
            _buffData.removeEventListener("update",__addBuff);
         }
         PlayerManager.Instance.Self.removeEventListener("propertychange",addGourdExpBottleBuffEvent);
      }
      
      private function initBuffButtons() : void
      {
         addGrowHelpIcon();
         addpayBuffIcon();
         setInfo(_buffData);
         _growHelpBuff.buffArray = _buffBtnArr;
         addLabyrinthBuff();
         addExpBuff();
         addAttestBuff();
         addRegressTicketBuff();
         addGourdExpBottleBuff();
      }
      
      private function addGourdExpBottleBuff() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 30)
         {
            SocketManager.Instance.addEventListener(PkgEvent.format(393),__addGourdExpBottleButton);
            SocketManager.Instance.out.sendStopExpStorage(1);
         }
      }
      
      private function __addGourdExpBottleButton(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var info:GourdExpBottleInfo = new GourdExpBottleInfo();
         info.UserID = pkg.readInt();
         info.TemplateID = pkg.readInt();
         info.Exp = pkg.readInt();
         info.Stage = pkg.readInt();
         info.IsFrist = pkg.readInt();
         if(info.Stage > 0)
         {
            if(!_gourdExpBottle)
            {
               _gourdExpBottle = new GourdExpBottleButton();
               _buffList.addChild(_gourdExpBottle);
            }
            _gourdExpBottle.gourdInfo = info;
         }
         else
         {
            deleteGourdExpBottleBtn();
         }
         if(info.IsFrist == 1)
         {
            BagAndInfoManager.Instance.hideBagAndInfo();
            NewHandContainer.Instance.showArrow(153,180,new Point(16 + x + (_buffList.numChildren - 1) * 32,73 + y),"","",LayerManager.Instance.getLayerByType(2));
         }
      }
      
      private function addAttestBuff() : void
      {
         if(!PlayerManager.Instance.Self.Sex && PathManager.girdAttestEnable)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.attest.icon");
            _attestBtn.buttonMode = true;
            _attestBtn.tipData = LanguageMgr.GetTranslation("ddt.HallStateView.attest");
            _buffList.addChild(_attestBtn);
            _attestBtn.setFrame(!!PlayerManager.Instance.Self.isAttest?1:2);
            if(!PlayerManager.Instance.Self.isAttest)
            {
               _attestBtn.addEventListener("click",__onAttestBtnClick);
            }
         }
      }
      
      protected function __onAttestBtnClick(event:MouseEvent) : void
      {
         var mc:MovieClip = ComponentFactory.Instance.creat("asset.hall.beautiful.attestHelpInfo");
         mc["qqText"].text = PathManager.getBeautyProveQQ();
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),mc,408,488);
      }
      
      private function addRegressTicketBuff() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(149,8),__addGetTicketBtn);
         SocketManager.Instance.out.sendRegressTicketInfo();
      }
      
      private function __addGetTicketBtn(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var level:int = pkg.readInt();
         var money:int = pkg.readInt();
         var bindMoney:int = pkg.readInt();
         var stockBindMoney:int = pkg.readInt();
         var currentBindMoney:int = pkg.readInt();
         var evt:CEvent = new CEvent("getTicket_data",[level,money,bindMoney,stockBindMoney,currentBindMoney]);
         GetTicketManager.instance.dispatchEvent(evt);
         if(stockBindMoney > 0)
         {
            addOldPlayerGetTicketBtn();
         }
         else
         {
            deleteGetTicketBtn();
         }
      }
      
      private function addOldPlayerGetTicketBtn() : void
      {
         if(!_getTicketBtn)
         {
            _getTicketBtn = ComponentFactory.Instance.creatComponentByStylename("hall.getTicketButton");
            _getTicketBtn.tipData = LanguageMgr.GetTranslation("ddt.regress.getticketIcon.tipText");
            _getTicketBtn.addEventListener("click",__onGetTicketClick);
         }
         _buffList.addChild(_getTicketBtn);
      }
      
      protected function __onGetTicketClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         GetTicketManager.instance.show();
      }
      
      private function addExpBuff() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(155,8),__addExpBlessedBtn);
         SocketManager.Instance.out.sendExpBlessedData();
      }
      
      protected function __addExpBlessedBtn(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var expValue:int = pkg.readInt();
         if(expValue != 0)
         {
            if(!_expBlessedIcon)
            {
               _expBlessedIcon = ComponentFactory.Instance.creatComponentByStylename("hall.expblessed.icon");
            }
            _expBlessedIcon.tipData = LanguageMgr.GetTranslation("ddt.HallStateView.expValue",expValue);
            _buffList.addChild(_expBlessedIcon);
         }
      }
      
      private function addGrowHelpIcon() : void
      {
         var i:int = 0;
         var item:* = null;
         _growHelpBuff = new GrowHelpBuffButton();
         _buffList.addChild(_growHelpBuff);
         _buffBtnArr = [];
         for(i = 0; i < 5; )
         {
            item = BuffButton.createBuffButton(i);
            _buffBtnArr.push(item);
            i++;
         }
      }
      
      private function addpayBuffIcon() : void
      {
         _payBuff = new PayBuffButton();
         _payBuff.CanClick = false;
         _buffList.addChild(_payBuff);
      }
      
      private function addLabyrinthBuff() : void
      {
         _growHelpBuff.buffArray = _buffBtnArr;
         var _loc3_:int = 0;
         var _loc2_:* = _buffData;
         for(var j in _buffData)
         {
            if(_buffData[j] != null)
            {
               if(_buffData[j].Type >= 74 && _buffData[j].Type <= 80)
               {
                  if(!_labyrinthBuff)
                  {
                     _labyrinthBuff = new LabyrinthBuffButton();
                     _buffList.addChild(_labyrinthBuff);
                     break;
                  }
               }
            }
         }
      }
      
      public function setInfo(buffData:DictionaryData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = buffData;
         for(var j in buffData)
         {
            if(buffData[j] != null)
            {
               var _loc3_:* = buffData[j].Type;
               if(13 !== _loc3_)
               {
                  if(12 !== _loc3_)
                  {
                     if(26 !== _loc3_)
                     {
                        if(110 !== _loc3_)
                        {
                           if(18 !== _loc3_)
                           {
                              if(70 !== _loc3_)
                              {
                                 if(51 !== _loc3_)
                                 {
                                    if(50 !== _loc3_)
                                    {
                                       if(52 !== _loc3_)
                                       {
                                          if(71 !== _loc3_)
                                          {
                                             if(72 !== _loc3_)
                                             {
                                                if(73 !== _loc3_)
                                                {
                                                   continue;
                                                }
                                             }
                                             addr89:
                                             _payBuff.addBuff(buffData[j]);
                                             continue;
                                          }
                                          addr88:
                                          §§goto(addr89);
                                       }
                                       addr87:
                                       §§goto(addr88);
                                    }
                                    addr86:
                                    §§goto(addr87);
                                 }
                                 addr85:
                                 §§goto(addr86);
                              }
                              §§goto(addr85);
                           }
                           else
                           {
                              _buffBtnArr[4].info = buffData[j];
                              continue;
                           }
                        }
                        else
                        {
                           _buffBtnArr[3].info = buffData[j];
                           continue;
                        }
                     }
                     else
                     {
                        _buffBtnArr[2].info = buffData[j];
                        continue;
                     }
                  }
                  else
                  {
                     _buffBtnArr[1].info = buffData[j];
                     continue;
                  }
               }
               else
               {
                  _buffBtnArr[0].info = buffData[j];
                  continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
      
      private function __addBuff(evt:DictionaryEvent) : void
      {
         var buffInfo:BuffInfo = evt.data as BuffInfo;
         var _loc3_:* = buffInfo.Type;
         if(13 !== _loc3_)
         {
            if(12 !== _loc3_)
            {
               if(26 !== _loc3_)
               {
                  if(110 !== _loc3_)
                  {
                     if(18 !== _loc3_)
                     {
                        if(70 !== _loc3_)
                        {
                           if(51 !== _loc3_)
                           {
                              if(50 !== _loc3_)
                              {
                                 if(52 !== _loc3_)
                                 {
                                    if(71 !== _loc3_)
                                    {
                                       if(72 !== _loc3_)
                                       {
                                          if(73 !== _loc3_)
                                          {
                                             if(74 !== _loc3_)
                                             {
                                                if(75 !== _loc3_)
                                                {
                                                   if(76 !== _loc3_)
                                                   {
                                                      if(77 !== _loc3_)
                                                      {
                                                         if(78 !== _loc3_)
                                                         {
                                                            if(79 !== _loc3_)
                                                            {
                                                               if(80 !== _loc3_)
                                                               {
                                                               }
                                                            }
                                                            addr71:
                                                            if(!_labyrinthBuff)
                                                            {
                                                               _labyrinthBuff = new LabyrinthBuffButton();
                                                               _buffList.addChild(_labyrinthBuff);
                                                            }
                                                         }
                                                         addr70:
                                                         §§goto(addr71);
                                                      }
                                                      addr69:
                                                      §§goto(addr70);
                                                   }
                                                   addr68:
                                                   §§goto(addr69);
                                                }
                                                addr67:
                                                §§goto(addr68);
                                             }
                                             §§goto(addr67);
                                          }
                                       }
                                       addr59:
                                       _payBuff.addBuff(buffInfo);
                                    }
                                    addr58:
                                    §§goto(addr59);
                                 }
                                 addr57:
                                 §§goto(addr58);
                              }
                              addr56:
                              §§goto(addr57);
                           }
                           addr55:
                           §§goto(addr56);
                        }
                        §§goto(addr55);
                     }
                     else
                     {
                        setBuffButtonInfo(4,buffInfo);
                     }
                  }
                  else
                  {
                     setBuffButtonInfo(3,buffInfo);
                  }
               }
               else
               {
                  setBuffButtonInfo(2,buffInfo);
               }
            }
            else
            {
               setBuffButtonInfo(1,buffInfo);
            }
         }
         else
         {
            setBuffButtonInfo(0,buffInfo);
         }
      }
      
      private function setBuffButtonInfo(btnId:int, buffinfo:BuffInfo) : void
      {
         if(buffinfo.IsExist)
         {
            _buffBtnArr[btnId].info = buffinfo;
         }
         else
         {
            _buffBtnArr[btnId].info.IsExist = false;
         }
      }
      
      private function __removeBuff(evt:DictionaryEvent) : void
      {
         var _loc2_:* = (evt.data as BuffInfo).Type;
         if(13 !== _loc2_)
         {
            if(12 !== _loc2_)
            {
               if(26 !== _loc2_)
               {
                  if(110 !== _loc2_)
                  {
                     if(18 === _loc2_)
                     {
                        _buffBtnArr[4].info = new BuffInfo(18);
                     }
                  }
                  else
                  {
                     _buffBtnArr[3].info = new BuffInfo(110);
                  }
               }
               else
               {
                  _buffBtnArr[2].info = new BuffInfo(26);
               }
            }
            else
            {
               _buffBtnArr[1].info = new BuffInfo(12);
            }
         }
         else
         {
            _buffBtnArr[0].info = new BuffInfo(13);
         }
      }
      
      private function __updateBuff(evt:DictionaryEvent) : void
      {
      }
      
      public function set CanClick(value:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _buffBtnArr;
         for each(var i in _buffBtnArr)
         {
            i.CanClick = value;
         }
      }
      
      private function deleteGetTicketBtn() : void
      {
         if(_getTicketBtn)
         {
            if(_buffList.contains(_getTicketBtn))
            {
               _buffList.removeChild(_getTicketBtn);
            }
            _getTicketBtn.removeEventListener("click",__onGetTicketClick);
            _getTicketBtn.dispose();
            _getTicketBtn = null;
         }
      }
      
      private function deleteExpBlessedBtn() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(155,8),__addExpBlessedBtn);
         if(_expBlessedIcon)
         {
            _expBlessedIcon.dispose();
            _expBlessedIcon = null;
         }
      }
      
      private function deleteGourdExpBottleBtn() : void
      {
         if(_gourdExpBottle)
         {
            _gourdExpBottle.dispose();
            _gourdExpBottle = null;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(PlayerManager.Instance.Self.Grade >= 30)
         {
            SocketManager.Instance.removeEventListener(PkgEvent.format(393),__addGourdExpBottleButton);
         }
         deleteGetTicketBtn();
         deleteExpBlessedBtn();
         deleteGourdExpBottleBtn();
         if(_growHelpBuff)
         {
            _growHelpBuff.dispose();
            _growHelpBuff = null;
         }
         if(_labyrinthBuff)
         {
            _labyrinthBuff.dispose();
            _labyrinthBuff = null;
         }
         if(_attestBtn)
         {
            _attestBtn.dispose();
            _attestBtn = null;
         }
         if(_buffList)
         {
            ObjectUtils.disposeObject(_buffList);
            _buffList = null;
         }
         _buffData = null;
         _buffBtnArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get buffBtnArr() : Array
      {
         return _buffBtnArr;
      }
   }
}
