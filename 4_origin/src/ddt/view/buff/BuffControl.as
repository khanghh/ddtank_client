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
      
      public function BuffControl(param1:String = "", param2:int = 0)
      {
         super();
         _spacing = param2;
         _str = param1;
         init();
         initEvents();
      }
      
      public static function isPayBuff(param1:BuffInfo) : Boolean
      {
         var _loc2_:* = param1.Type;
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
                        addr12:
                        return true;
                     }
                     addr11:
                     §§goto(addr12);
                  }
                  addr10:
                  §§goto(addr11);
               }
               addr9:
               §§goto(addr10);
            }
            addr8:
            §§goto(addr9);
         }
         §§goto(addr8);
      }
      
      private function init() : void
      {
         _buffData = PlayerManager.Instance.Self.buffInfo;
         _buffList = new HBox();
         _buffList.spacing = _spacing;
         addChild(_buffList);
         initBuffButtons();
      }
      
      public function set boxSpacing(param1:int) : void
      {
         _buffList.spacing = param1;
      }
      
      private function initEvents() : void
      {
         _buffData.addEventListener("add",__addBuff);
         _buffData.addEventListener("remove",__removeBuff);
         _buffData.addEventListener("update",__addBuff);
         PlayerManager.Instance.Self.addEventListener("propertychange",addGourdExpBottleBuffEvent);
      }
      
      protected function addGourdExpBottleBuffEvent(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"])
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
      
      private function __addGourdExpBottleButton(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:GourdExpBottleInfo = new GourdExpBottleInfo();
         _loc3_.UserID = _loc2_.readInt();
         _loc3_.TemplateID = _loc2_.readInt();
         _loc3_.Exp = _loc2_.readInt();
         _loc3_.Stage = _loc2_.readInt();
         _loc3_.IsFrist = _loc2_.readInt();
         if(_loc3_.Stage > 0)
         {
            if(!_gourdExpBottle)
            {
               _gourdExpBottle = new GourdExpBottleButton();
               _buffList.addChild(_gourdExpBottle);
            }
            _gourdExpBottle.gourdInfo = _loc3_;
         }
         else
         {
            deleteGourdExpBottleBtn();
         }
         if(_loc3_.IsFrist == 1)
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
      
      protected function __onAttestBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.hall.beautiful.attestHelpInfo");
         _loc2_["qqText"].text = PathManager.getBeautyProveQQ();
         HelpFrameUtils.Instance.simpleHelpFrame(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),_loc2_,408,488);
      }
      
      private function addRegressTicketBuff() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(149,8),__addGetTicketBtn);
         SocketManager.Instance.out.sendRegressTicketInfo();
      }
      
      private function __addGetTicketBtn(param1:PkgEvent) : void
      {
         var _loc7_:PackageIn = param1.pkg;
         var _loc2_:int = _loc7_.readInt();
         var _loc5_:int = _loc7_.readInt();
         var _loc6_:int = _loc7_.readInt();
         var _loc3_:int = _loc7_.readInt();
         var _loc8_:int = _loc7_.readInt();
         var _loc4_:CEvent = new CEvent("getTicket_data",[_loc2_,_loc5_,_loc6_,_loc3_,_loc8_]);
         GetTicketManager.instance.dispatchEvent(_loc4_);
         if(_loc3_ > 0)
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
      
      protected function __onGetTicketClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         GetTicketManager.instance.show();
      }
      
      private function addExpBuff() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(155,8),__addExpBlessedBtn);
         SocketManager.Instance.out.sendExpBlessedData();
      }
      
      protected function __addExpBlessedBtn(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_ != 0)
         {
            if(!_expBlessedIcon)
            {
               _expBlessedIcon = ComponentFactory.Instance.creatComponentByStylename("hall.expblessed.icon");
            }
            _expBlessedIcon.tipData = LanguageMgr.GetTranslation("ddt.HallStateView.expValue",_loc2_);
            _buffList.addChild(_expBlessedIcon);
         }
      }
      
      private function addGrowHelpIcon() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _growHelpBuff = new GrowHelpBuffButton();
         _buffList.addChild(_growHelpBuff);
         _buffBtnArr = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = BuffButton.createBuffButton(_loc2_);
            _buffBtnArr.push(_loc1_);
            _loc2_++;
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
         for(var _loc1_ in _buffData)
         {
            if(_buffData[_loc1_] != null)
            {
               if(_buffData[_loc1_].Type >= 74 && _buffData[_loc1_].Type <= 80)
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
      
      public function setInfo(param1:DictionaryData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc2_ in param1)
         {
            if(param1[_loc2_] != null)
            {
               var _loc3_:* = param1[_loc2_].Type;
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
                                             addr75:
                                             _payBuff.addBuff(param1[_loc2_]);
                                             continue;
                                          }
                                          addr74:
                                          §§goto(addr75);
                                       }
                                       addr73:
                                       §§goto(addr74);
                                    }
                                    addr72:
                                    §§goto(addr73);
                                 }
                                 addr71:
                                 §§goto(addr72);
                              }
                              §§goto(addr71);
                           }
                           else
                           {
                              _buffBtnArr[4].info = param1[_loc2_];
                              continue;
                           }
                        }
                        else
                        {
                           _buffBtnArr[3].info = param1[_loc2_];
                           continue;
                        }
                     }
                     else
                     {
                        _buffBtnArr[2].info = param1[_loc2_];
                        continue;
                     }
                  }
                  else
                  {
                     _buffBtnArr[1].info = param1[_loc2_];
                     continue;
                  }
               }
               else
               {
                  _buffBtnArr[0].info = param1[_loc2_];
                  continue;
               }
            }
            else
            {
               continue;
            }
         }
      }
      
      private function __addBuff(param1:DictionaryEvent) : void
      {
         var _loc2_:BuffInfo = param1.data as BuffInfo;
         var _loc3_:* = _loc2_.Type;
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
                                                            addr59:
                                                            if(!_labyrinthBuff)
                                                            {
                                                               _labyrinthBuff = new LabyrinthBuffButton();
                                                               _buffList.addChild(_labyrinthBuff);
                                                            }
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
                                       }
                                       addr48:
                                       _payBuff.addBuff(_loc2_);
                                    }
                                    addr47:
                                    §§goto(addr48);
                                 }
                                 addr46:
                                 §§goto(addr47);
                              }
                              addr45:
                              §§goto(addr46);
                           }
                           addr44:
                           §§goto(addr45);
                        }
                        §§goto(addr44);
                     }
                     else
                     {
                        setBuffButtonInfo(4,_loc2_);
                     }
                  }
                  else
                  {
                     setBuffButtonInfo(3,_loc2_);
                  }
               }
               else
               {
                  setBuffButtonInfo(2,_loc2_);
               }
            }
            else
            {
               setBuffButtonInfo(1,_loc2_);
            }
         }
         else
         {
            setBuffButtonInfo(0,_loc2_);
         }
      }
      
      private function setBuffButtonInfo(param1:int, param2:BuffInfo) : void
      {
         if(param2.IsExist)
         {
            _buffBtnArr[param1].info = param2;
         }
         else
         {
            _buffBtnArr[param1].info.IsExist = false;
         }
      }
      
      private function __removeBuff(param1:DictionaryEvent) : void
      {
         var _loc2_:* = (param1.data as BuffInfo).Type;
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
      
      private function __updateBuff(param1:DictionaryEvent) : void
      {
      }
      
      public function set CanClick(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _buffBtnArr;
         for each(var _loc2_ in _buffBtnArr)
         {
            _loc2_.CanClick = param1;
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
