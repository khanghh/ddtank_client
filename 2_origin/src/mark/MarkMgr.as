package mark
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mark.analyzer.MarkChipAnalyzer;
   import mark.analyzer.MarkHammerAnalyzer;
   import mark.analyzer.MarkProAnalyzer;
   import mark.analyzer.MarkSetAnalyzer;
   import mark.analyzer.MarkSuitAnalyzer;
   import mark.analyzer.MarkTransferAnalyzer;
   import mark.data.MarkBagData;
   import mark.data.MarkChipData;
   import mark.data.MarkChipTemplateData;
   import mark.data.MarkHammerTemplateData;
   import mark.data.MarkModel;
   import mark.data.MarkProData;
   import mark.data.MarkTransferTemplateData;
   import mark.event.MarkEvent;
   import road7th.comm.PackageIn;
   
   public class MarkMgr extends EventDispatcher
   {
      
      private static var _inst:MarkMgr = null;
       
      
      private var _model:MarkModel;
      
      private var _markContainer:DisplayObjectContainer = null;
      
      private var _otherContainer:DisplayObjectContainer = null;
      
      private var _treasureRoomContainer:DisplayObjectContainer = null;
      
      private var _alert:BaseAlerFrame = null;
      
      private var _sellAlert:BaseAlerFrame = null;
      
      public var isFarmMark:Boolean = true;
      
      public var treasureRoomLogoIdArr:Array;
      
      public var treasureRoomRewardArr:Array;
      
      public var isFull:Boolean;
      
      public var isOther:Boolean = false;
      
      public function MarkMgr(param1:SingTon)
      {
         treasureRoomLogoIdArr = [];
         treasureRoomRewardArr = [];
         super();
         if(!param1)
         {
            throw new Error("this is a single instance");
         }
      }
      
      public static function get inst() : MarkMgr
      {
         if(!_inst)
         {
            _inst = new MarkMgr(new SingTon());
         }
         return _inst;
      }
      
      public function setup() : void
      {
         _model = new MarkModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(529,2),__resSyncOrUpdateChips);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,16),__resMarkMoney);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,26),__updateChipsInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,4),__resHammerChip);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,7),__resTransferChip);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,8),__resTransferSubmit);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,24),__resOperationStatus);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,23),__onVaultsData);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,22),__onVaultsReward);
         SocketManager.Instance.addEventListener(PkgEvent.format(533),__auctionGetMarkTips);
      }
      
      private function __updateChipsInfo(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Vector.<MarkChipData> = new Vector.<MarkChipData>();
         var _loc5_:int = param1.pkg.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc2_ = new MarkChipData();
            _loc2_.itemID = param1.pkg.readInt();
            _loc2_.templateId = param1.pkg.readInt();
            _loc2_.position = param1.pkg.readInt();
            _loc2_.isExist = param1.pkg.readBoolean();
            if(!_loc2_.isExist)
            {
               param1.pkg.readBoolean();
               _loc4_.push(_loc2_);
            }
            else
            {
               param1.pkg.readBoolean();
               _loc2_.isbind = param1.pkg.readBoolean();
               _loc2_.bornLv = param1.pkg.readInt();
               _loc2_.hammerLv = param1.pkg.readInt();
               _loc2_.hLv = param1.pkg.readInt();
               _loc7_ = new MarkProData();
               _loc7_.type = param1.pkg.readInt();
               _loc7_.value = param1.pkg.readInt();
               _loc7_.attachValue = param1.pkg.readInt();
               _loc2_.mainPro = _loc7_;
               _loc2_.props = new Vector.<MarkProData>();
               _loc6_ = 0;
               while(_loc6_ < 4)
               {
                  _loc3_ = new MarkProData();
                  _loc3_.type = param1.pkg.readInt();
                  _loc3_.value = param1.pkg.readInt();
                  _loc3_.attachValue = param1.pkg.readInt();
                  _loc3_.hummerCount = param1.pkg.readInt();
                  _loc2_.props.push(_loc3_);
                  _loc6_++;
               }
               _loc4_.push(_loc2_);
            }
            _loc8_++;
         }
         updateChips(_loc4_);
      }
      
      public function updateChips(param1:Vector.<MarkChipData>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_] as MarkChipData;
            if(!_model.getChipById(_loc2_.itemID))
            {
               _model.bags[_loc2_.position > 1000?_loc2_.position:1].chips[_loc2_.itemID] = _loc2_;
            }
            else
            {
               delete _model.bags[_model.getChipById(_loc2_.itemID).position > 1000?_model.getChipById(_loc2_.itemID).position:1].chips[_loc2_.itemID];
               if(_loc2_.isExist)
               {
                  _model.bags[_loc2_.position > 1000?_loc2_.position:1].chips[_loc2_.itemID] = _loc2_;
               }
            }
            _loc3_++;
         }
         dispatchEvent(new MarkEvent("updateChips"));
      }
      
      private function __auctionGetMarkTips(param1:PkgEvent) : void
      {
      }
      
      public function showMarkView(param1:DisplayObjectContainer, param2:PlayerInfo = null) : void
      {
         parent = param1;
         info = param2;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkSetLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkHammerLoader());
         AssetModuleLoader.addModelLoader("mark",7);
         AssetModuleLoader.startCodeLoader(function():void
         {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc1_:* = null;
            if(parent)
            {
               if(!info)
               {
                  if(_markContainer)
                  {
                     _markContainer.visible = false;
                  }
                  if(_otherContainer)
                  {
                     _otherContainer.visible = false;
                  }
                  if(_treasureRoomContainer)
                  {
                     _treasureRoomContainer.visible = false;
                  }
                  if(!_markContainer)
                  {
                     _markContainer = new Sprite();
                     parent.addChild(_markContainer);
                  }
                  isOther = false;
                  _markContainer.visible = true;
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("mark.leftView");
                  _markContainer.addChild(_loc2_);
                  _loc3_ = ComponentFactory.Instance.creatCustomObject("mark.rightView");
                  _markContainer.addChild(_loc3_);
               }
               else
               {
                  if(!_otherContainer)
                  {
                     _otherContainer = new Sprite();
                     parent.addChild(_otherContainer);
                  }
                  isOther = true;
                  _otherContainer.visible = true;
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("mark.otherView",[info]);
                  _otherContainer.addChild(_loc1_);
                  if(!_otherContainer.parent)
                  {
                     parent.addChild(_otherContainer);
                  }
               }
            }
         });
      }
      
      public function showTreasureRoomView() : void
      {
         AssetModuleLoader.addModelLoader("treasureRoom",7);
         AssetModuleLoader.startCodeLoader(function():void
         {
            if(_markContainer)
            {
               _markContainer.visible = false;
            }
            if(_otherContainer)
            {
               _otherContainer.visible = false;
            }
            if(_treasureRoomContainer)
            {
               _treasureRoomContainer.visible = false;
            }
            if(!_treasureRoomContainer)
            {
               _treasureRoomContainer = ComponentFactory.Instance.creatCustomObject("core.treasureRoomView");
               _markContainer.parent.addChild(_treasureRoomContainer);
            }
            else
            {
               if(!_treasureRoomContainer.parent)
               {
                  _markContainer.parent.addChild(_treasureRoomContainer);
               }
               _treasureRoomContainer.visible = true;
            }
            SocketManager.Instance.out.sendTreasureRoomData();
         });
      }
      
      public function setMarkChipTempalte(param1:MarkChipAnalyzer) : void
      {
         _model.cfgChip = param1.chips;
      }
      
      public function setMarkSuitTempalte(param1:MarkSuitAnalyzer) : void
      {
         _model.cfgSuit = param1.suits;
      }
      
      public function setMarkProInfo(param1:MarkProAnalyzer) : void
      {
         _model.proNumInfoArr = param1.proNumDic;
      }
      
      public function setMarkSetTempalte(param1:MarkSetAnalyzer) : void
      {
         _model.cfgSet = param1.sets;
      }
      
      public function setMarkHammerTempalte(param1:MarkHammerAnalyzer) : void
      {
         _model.cfgHammer = param1.hammers;
      }
      
      public function setMarkTransferTempalte(param1:MarkTransferAnalyzer) : void
      {
         _model.cfgTransfer = param1.transfers;
      }
      
      public function showMarkMainFrame() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkProInfoLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkHammerLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkTransferLoader());
         AssetModuleLoader.startCodeLoader(function():void
         {
            var _loc1_:* = ComponentFactory.Instance.creatCustomObject("mark.mainFrame");
            LayerManager.Instance.addToLayer(_loc1_,3,false,1);
         });
      }
      
      private function disposeBooksAndTreasureRoom() : void
      {
         if(_markContainer)
         {
            ObjectUtils.disposeObject(_markContainer);
         }
         _markContainer = null;
         if(_otherContainer)
         {
            ObjectUtils.disposeObject(_otherContainer);
         }
         _otherContainer = null;
         if(_treasureRoomContainer)
         {
            ObjectUtils.disposeObject(_treasureRoomContainer);
         }
         _treasureRoomContainer = null;
      }
      
      public function removeMarkView() : void
      {
         dispatchEvent(new MarkEvent("remove_view"));
         disposeBooksAndTreasureRoom();
      }
      
      public function chooseEquip(param1:int) : void
      {
         _model.equip = MarkModel.EQUIP_LIST[param1];
         dispatchEvent(new MarkEvent("choose_equip"));
      }
      
      public function getEquipList() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < MarkModel.EQUIP_LIST.length)
         {
            _loc1_.push(PlayerManager.Instance.Self.Bag.items[MarkModel.EQUIP_LIST[_loc2_]]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function checkTip(param1:int, param2:int) : Boolean
      {
         if(param2 == 0 && param1 == 1 || param2 == 2 && param1 == 3 || param2 == 3 && param1 == 4 || param2 == 5 && param1 == 6 || param2 == 11 && param1 == 13 || param2 == 4 && param1 == 5)
         {
            return true;
         }
         return false;
      }
      
      public function reqOperationStatus(param1:int, param2:int) : void
      {
         SocketManager.Instance.out.sendOperationStatus(param1,param2);
         var _loc4_:Array = _model.newSuits;
         var _loc3_:int = _loc4_.indexOf(param2);
         if(_loc3_ > -1)
         {
            _loc4_.splice(_loc3_,1);
         }
         dispatchEvent(new MarkEvent("updateOperation"));
      }
      
      public function getHammerData(param1:int, param2:int) : MarkHammerTemplateData
      {
         var _loc4_:int = 0;
         param1 = Math.min(param1 + 1,getHammerTopLv(param2));
         var _loc3_:MarkHammerTemplateData = null;
         _loc4_ = 0;
         while(_loc4_ < _model.cfgHammer.length)
         {
            _loc3_ = _model.cfgHammer[_loc4_];
            if(_loc3_.Character == param2 && _loc3_.Level == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getHammerTopLv(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _model.cfgHammer.length)
         {
            if(_model.cfgHammer[_loc3_].Character == param1 && _model.cfgHammer[_loc3_].Level >= _loc2_)
            {
               _loc2_ = _model.cfgHammer[_loc3_].Level;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTransferData(param1:int, param2:int) : MarkTransferTemplateData
      {
         var _loc4_:int = 0;
         var _loc3_:MarkTransferTemplateData = null;
         _loc4_ = 0;
         while(_loc4_ < _model.cfgTransfer.length)
         {
            _loc3_ = _model.cfgTransfer[_loc4_];
            if(_loc3_.Character == param1 && _loc3_.Grade == param2)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getAttributeAdd(param1:int, param2:int) : int
      {
         var _loc3_:MarkChipTemplateData = _model.cfgChip[param1];
         if(!_loc3_)
         {
            return 0;
         }
         var _loc4_:int = 0;
         var _loc5_:* = param2;
         if(31 !== _loc5_)
         {
            if(32 !== _loc5_)
            {
               if(33 !== _loc5_)
               {
                  if(34 !== _loc5_)
                  {
                     if(37 !== _loc5_)
                     {
                        if(36 !== _loc5_)
                        {
                           if(35 !== _loc5_)
                           {
                              if(101 !== _loc5_)
                              {
                                 if(102 !== _loc5_)
                                 {
                                    if(1 !== _loc5_)
                                    {
                                       if(3 !== _loc5_)
                                       {
                                          if(7 !== _loc5_)
                                          {
                                             if(9 !== _loc5_)
                                             {
                                                if(5 === _loc5_)
                                                {
                                                   _loc4_ = _loc3_.AttributeAdd14;
                                                }
                                             }
                                             else
                                             {
                                                _loc4_ = _loc3_.AttributeAdd13;
                                             }
                                          }
                                          else
                                          {
                                             _loc4_ = _loc3_.AttributeAdd12;
                                          }
                                       }
                                       else
                                       {
                                          _loc4_ = _loc3_.AttributeAdd11;
                                       }
                                    }
                                    else
                                    {
                                       _loc4_ = _loc3_.AttributeAdd10;
                                    }
                                 }
                                 else
                                 {
                                    _loc4_ = _loc3_.AttributeAdd9;
                                 }
                              }
                              else
                              {
                                 _loc4_ = _loc3_.AttributeAdd8;
                              }
                           }
                           else
                           {
                              _loc4_ = _loc3_.AttributeAdd7;
                           }
                        }
                        else
                        {
                           _loc4_ = _loc3_.AttributeAdd6;
                        }
                     }
                     else
                     {
                        _loc4_ = _loc3_.AttributeAdd5;
                     }
                  }
                  else
                  {
                     _loc4_ = _loc3_.AttributeAdd4;
                  }
               }
               else
               {
                  _loc4_ = _loc3_.AttributeAdd3;
               }
            }
            else
            {
               _loc4_ = _loc3_.AttributeAdd2;
            }
         }
         else
         {
            _loc4_ = _loc3_.AttributeAdd1;
         }
         return int(_loc4_ * 0.1 * (_model.getChipById(_model.chipItemID).hLv + 1));
      }
      
      public function getMarkProValue(param1:MarkChipData, param2:int) : int
      {
         var _loc4_:int = 0;
         if(param1.mainPro.type == param2)
         {
            _loc4_ = _loc4_ + (param1.mainPro.value + param1.mainPro.attachValue);
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1.props;
         for each(var _loc3_ in param1.props)
         {
            if(_loc3_.type == param2)
            {
               _loc4_ = _loc4_ + (_loc3_.value + _loc3_.attachValue);
            }
         }
         return _loc4_;
      }
      
      public function checkMarkOpen(param1:PlayerInfo = null) : Boolean
      {
         param1 = !!param1?param1:PlayerManager.Instance.Self;
         return param1.Grade >= ServerConfigManager.instance.markOpenLevel;
      }
      
      public function get model() : MarkModel
      {
         return _model;
      }
      
      public function submitTransfer() : void
      {
         _alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("mark.cancel"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1,null,"OneLineTxtAlert");
         _alert.addEventListener("response",alertHandler);
      }
      
      public function submitSell() : void
      {
         _sellAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("mark.sell",getSellDemand()),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1,null,"OneLineTxtAlert");
         _sellAlert.addEventListener("response",alertHandler);
      }
      
      private function getSellDemand() : int
      {
         var _loc1_:int = 0;
         if(_model.sellList == null || _model.sellList.length == 0)
         {
            return 0;
         }
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _model.sellList.length)
         {
            _loc2_ = _loc2_ + calculateDemand(_model.sellList[_loc1_]);
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function calculateDemand(param1:int) : int
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:MarkChipData = _model.getChipById(param1);
         var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_loc5_.templateId);
         var _loc4_:MarkChipTemplateData = _model.cfgChip[_loc5_.templateId];
         _loc8_ = _loc8_ + _loc3_.ReclaimValue;
         _loc8_ = _loc8_ + _loc5_.bornLv * ServerConfigManager.instance.EngraveSaleStarConfig;
         var _loc7_:int = 0;
         var _loc2_:MarkHammerTemplateData = null;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.hLv)
         {
            _loc2_ = getHammerData(_loc6_,_loc4_.Character);
            if(_loc2_)
            {
               _loc7_ = _loc7_ + _loc2_.Expend;
            }
            _loc6_++;
         }
         _loc8_ = _loc8_ + _loc7_ * ServerConfigManager.instance.EngraveSaleTemperConsumeConfig / 100;
         return _loc8_;
      }
      
      private function alertHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",alertHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(_loc2_ == _sellAlert)
               {
                  _model.sellList.length = 0;
                  MarkMgr.inst.dispatchEvent(new MarkEvent("cancelSell"));
                  break;
               }
               break;
            case 2:
            case 3:
            case 4:
               if(_loc2_ == _alert)
               {
                  SocketManager.Instance.out.sendSubmitTransfer(1);
               }
               else if(_loc2_ == _sellAlert)
               {
                  if(!MarkMgr.inst.model.sellStatus)
                  {
                     if(_model.getChipById(_model.sellList[0]).bornLv > 3)
                     {
                        submitHighStarSell();
                     }
                     else
                     {
                        reqSellChips();
                     }
                  }
                  else
                  {
                     reqSellChips();
                  }
               }
         }
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function alertSecondHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",alertSecondHandler);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _model.sellList.length = 0;
               MarkMgr.inst.dispatchEvent(new MarkEvent("cancelSell"));
               break;
            case 2:
            case 3:
            case 4:
               reqSellChips();
         }
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      public function submitHighStarSell() : void
      {
         _sellAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("mark.Single.highStar.sell"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1,null,"OneLineTxtAlert");
         _sellAlert.addEventListener("response",alertSecondHandler);
      }
      
      public function sortedProps(param1:Dictionary) : Array
      {
         var _loc4_:Array = [null,null,null,null,null,null,null,null,null,null,null,null,null,null];
         var _loc5_:Array = [31,32,33,34,101,102,36,35,37,9,1,3,7,5];
         var _loc2_:int = -1;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_ = _loc5_.indexOf(_loc3_.type);
            if(_loc2_ > -1)
            {
               _loc4_[_loc2_] = _loc3_;
            }
         }
         return _loc4_;
      }
      
      public function getEquipProps() : Dictionary
      {
         return calculateEquipProps(_model.equip);
      }
      
      public function calculateEquipProps(param1:int) : Dictionary
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Dictionary = new Dictionary();
         var _loc4_:MarkProData = null;
         _loc6_ = 0;
         while(_loc6_ < _model.getChipsByEquipType(param1).length)
         {
            _loc2_ = _model.getChipsByEquipType(param1)[_loc6_];
            if(_loc2_)
            {
               _loc4_ = _loc2_.mainPro;
               if(!_loc5_.hasOwnProperty(_loc4_.type))
               {
                  _loc5_[_loc4_.type] = new MarkProData();
               }
               _loc5_[_loc4_.type].type = _loc2_.mainPro.type;
               _loc5_[_loc4_.type].value = _loc5_[_loc4_.type].value + _loc4_.value;
               _loc5_[_loc4_.type].attachValue = _loc5_[_loc4_.type].attachValue + _loc4_.attachValue;
               var _loc8_:int = 0;
               var _loc7_:* = _loc2_.props;
               for each(var _loc3_ in _loc2_.props)
               {
                  if(!_loc5_.hasOwnProperty(_loc3_.type))
                  {
                     _loc5_[_loc3_.type] = new MarkProData();
                  }
                  _loc5_[_loc3_.type].type = _loc3_.type;
                  _loc5_[_loc3_.type].value = _loc5_[_loc3_.type].value + _loc3_.value;
                  _loc5_[_loc3_.type].attachValue = _loc5_[_loc3_.type].attachValue + _loc3_.attachValue;
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function __resSyncOrUpdateChips(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Boolean = false;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc6_:MarkBagData = new MarkBagData();
         _loc6_.type = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc2_ = new MarkChipData();
            _loc2_.itemID = param1.pkg.readInt();
            _loc2_.templateId = param1.pkg.readInt();
            _loc2_.position = param1.pkg.readInt();
            _loc5_ = param1.pkg.readBoolean();
            if(!_loc5_)
            {
               param1.pkg.readBoolean();
            }
            else
            {
               param1.pkg.readBoolean();
               _loc2_.isbind = param1.pkg.readBoolean();
               _loc2_.bornLv = param1.pkg.readInt();
               _loc2_.hammerLv = param1.pkg.readInt();
               _loc2_.hLv = param1.pkg.readInt();
               _loc8_ = new MarkProData();
               _loc8_.type = param1.pkg.readInt();
               _loc8_.value = param1.pkg.readInt();
               _loc8_.attachValue = param1.pkg.readInt();
               _loc2_.mainPro = _loc8_;
               _loc2_.props = new Vector.<MarkProData>();
               _loc7_ = 0;
               while(_loc7_ < 4)
               {
                  _loc3_ = new MarkProData();
                  _loc3_.type = param1.pkg.readInt();
                  _loc3_.value = param1.pkg.readInt();
                  _loc3_.attachValue = param1.pkg.readInt();
                  _loc3_.hummerCount = param1.pkg.readInt();
                  _loc2_.props.push(_loc3_);
                  _loc7_++;
               }
               _loc6_.chips[_loc2_.itemID] = _loc2_;
            }
            _loc9_++;
         }
         _model.bags[_loc6_.type] = _loc6_;
      }
      
      public function reqSyncOrUpdateChips() : void
      {
         SocketManager.Instance.out.sendUserAllDebris();
      }
      
      public function moveChip(param1:int) : void
      {
         var _loc2_:int = 0;
         if(checkChipExist(param1))
         {
            _loc2_ = MarkModel.EQUIP_LIST.indexOf(_model.equip) + 1;
            SocketManager.Instance.out.sendOnOrOffChip(param1,_loc2_);
         }
      }
      
      private function checkChipExist(param1:int) : Boolean
      {
         if(!_model.getChipById(param1))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error1"));
            return false;
         }
         return true;
      }
      
      public function reqSellChips() : void
      {
         var _loc1_:Array = _model.sellList;
         if(!_loc1_ || _loc1_.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error4"));
         }
         else
         {
            SocketManager.Instance.out.sendSellChips(_loc1_);
         }
         MarkMgr.inst.dispatchEvent(new MarkEvent("cancelSell"));
      }
      
      private function __resHammerChip(param1:PkgEvent) : void
      {
         var _loc3_:Boolean = param1.pkg.readBoolean();
         var _loc2_:int = param1.pkg.readInt();
         var _loc4_:int = param1.pkg.readInt();
         dispatchEvent(new MarkEvent("hammerResult",{
            "result":_loc3_,
            "cnt":_loc4_ - 1
         }));
      }
      
      public function reqHammerChip(param1:int = 1) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(checkChipExist(_model.chipItemID))
         {
            _loc2_ = _model.getChipById(_model.chipItemID);
            _loc3_ = getHammerData(_loc2_.hLv,_model.cfgChip[_loc2_.templateId].Character);
            if(_loc3_.Expend > _model.markMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error5"));
               return;
            }
            if(_loc2_.hLv >= getHammerTopLv(_model.cfgChip[_loc2_.templateId].Character))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error6"));
               return;
            }
            SocketManager.Instance.out.sendHammerChip(_model.chipItemID,param1);
         }
      }
      
      private function __resMarkMoney(param1:PkgEvent) : void
      {
         _model.markMoney = param1.pkg.readInt();
         dispatchEvent(new MarkEvent("markMoney"));
      }
      
      public function reqTransferChip(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(checkChipExist(_model.chipItemID))
         {
            if(verfyPro(param1))
            {
               _loc2_ = _model.getChipById(_model.chipItemID);
               _loc3_ = ItemManager.Instance.getTemplateById(_loc2_.templateId);
               _loc4_ = this.getTransferData(_loc3_.Quality,_loc2_.bornLv + _loc2_.hammerLv);
               if(_loc4_.Expend > _model.markMoney)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error9"));
                  return;
               }
               if(_loc4_.NeedMaterial > PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12200))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error10"));
                  return;
               }
               SocketManager.Instance.out.sendTransferChip(_model.chipItemID,param1);
            }
         }
      }
      
      private function verfyPro(param1:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc2_:MarkChipData = _model.getChipById(_model.chipItemID);
         if(_loc2_)
         {
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc2_.props && _loc4_ < _loc2_.props.length)
            {
               if(_loc2_.props[_loc4_].type == param1)
               {
                  return true;
               }
               _loc4_++;
            }
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error8"));
         return false;
      }
      
      private function __resTransferChip(param1:PkgEvent) : void
      {
         var _loc4_:MarkProData = new MarkProData();
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:int = param1.pkg.readInt();
         _loc4_.type = param1.pkg.readInt();
         _loc4_.value = param1.pkg.readInt();
         _loc4_.hummerCount = param1.pkg.readInt();
         _model.transferPro = _loc4_;
         dispatchEvent(new MarkEvent("transferResult"));
      }
      
      public function reqTransferSubmit(param1:Boolean = true) : void
      {
         if(!param1)
         {
            submitTransfer();
         }
         else
         {
            SocketManager.Instance.out.sendSubmitTransfer(0);
         }
      }
      
      private function __resTransferSubmit(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         _model.transferPro = null;
         dispatchEvent(new MarkEvent("submitResult"));
      }
      
      private function __resOperationStatus(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = param1.pkg.readInt();
         var _loc3_:Array = _model.newSuits;
         _loc3_.length = 0;
         var _loc2_:int = param1.pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_.push(param1.pkg.readInt());
            _loc5_++;
         }
         dispatchEvent(new MarkEvent("updateOperation"));
      }
      
      protected function __onVaultsData(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc4_:Array = [];
         var _loc3_:Number = _loc5_.readLong();
         _loc4_.push(_loc3_);
         var _loc2_:int = _loc5_.readInt();
         _loc4_.push(_loc2_);
         dispatchEvent(new MarkEvent("vaultsData",_loc4_));
      }
      
      protected function __onVaultsReward(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc5_:int = _loc4_.readInt();
         isFull = _loc4_.readBoolean();
         if(!isFull)
         {
            _loc3_ = _loc4_.readInt();
            treasureRoomRewardArr = [];
            treasureRoomLogoIdArr = [];
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc2_ = _loc4_.readInt();
               _loc7_ = ItemManager.fillByID(_loc2_);
               _loc7_.Count = _loc4_.readInt();
               treasureRoomRewardArr.push(_loc7_);
               _loc6_ = _loc4_.readInt();
               treasureRoomLogoIdArr.push(_loc6_);
               _loc8_++;
            }
         }
         dispatchEvent(new MarkEvent("vaultsReward",_loc5_));
      }
      
      public function showMark() : void
      {
         if(_otherContainer)
         {
            _otherContainer.visible = false;
         }
         if(_treasureRoomContainer)
         {
            _treasureRoomContainer.visible = false;
         }
         _markContainer.visible = true;
      }
   }
}

class SingTon
{
    
   
   function SingTon()
   {
      super();
   }
}
