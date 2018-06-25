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
   import mark.data.MarkSchemeInfo;
   import mark.data.MarkSchemeModel;
   import mark.data.MarkTransferTemplateData;
   import mark.event.MarkEvent;
   import road7th.comm.PackageIn;
   
   public class MarkMgr extends EventDispatcher
   {
      
      private static var _inst:MarkMgr = null;
       
      
      private var _model:MarkModel;
      
      private var _schemeModel:MarkSchemeModel = null;
      
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
      
      public var needSave:Boolean = false;
      
      public function MarkMgr(sigle:SingTon)
      {
         treasureRoomLogoIdArr = [];
         treasureRoomRewardArr = [];
         super();
         if(!sigle)
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
         _schemeModel = new MarkSchemeModel();
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
         SocketManager.Instance.addEventListener(PkgEvent.format(529,29),__resEquipScheme);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,31),__resAddEquipScheme);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,32),__resSwitchEquipScheme);
         SocketManager.Instance.addEventListener(PkgEvent.format(529,30),__resSaveScheme);
      }
      
      private function __updateChipsInfo(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var chip:* = null;
         var mainPro:* = null;
         var j:int = 0;
         var subPro:* = null;
         var changeChips:Vector.<MarkChipData> = new Vector.<MarkChipData>();
         var count:int = pkg.pkg.readInt();
         for(i = 0; i < count; )
         {
            chip = new MarkChipData();
            chip.itemID = pkg.pkg.readInt();
            chip.templateId = pkg.pkg.readInt();
            chip.position = pkg.pkg.readInt();
            chip.isExist = pkg.pkg.readBoolean();
            if(!chip.isExist)
            {
               pkg.pkg.readBoolean();
               changeChips.push(chip);
            }
            else
            {
               pkg.pkg.readBoolean();
               chip.isbind = pkg.pkg.readBoolean();
               chip.bornLv = pkg.pkg.readInt();
               chip.hammerLv = pkg.pkg.readInt();
               chip.hLv = pkg.pkg.readInt();
               mainPro = new MarkProData();
               mainPro.type = pkg.pkg.readInt();
               mainPro.value = pkg.pkg.readInt();
               mainPro.attachValue = pkg.pkg.readInt();
               chip.mainPro = mainPro;
               chip.props = new Vector.<MarkProData>();
               for(j = 0; j < 4; )
               {
                  subPro = new MarkProData();
                  subPro.type = pkg.pkg.readInt();
                  subPro.value = pkg.pkg.readInt();
                  subPro.attachValue = pkg.pkg.readInt();
                  subPro.hummerCount = pkg.pkg.readInt();
                  chip.props.push(subPro);
                  j++;
               }
               changeChips.push(chip);
            }
            i++;
         }
         updateChips(changeChips);
      }
      
      public function updateChips(list:Vector.<MarkChipData>) : void
      {
         var n:int = 0;
         var chip:* = null;
         for(n = 0; n < list.length; )
         {
            chip = list[n] as MarkChipData;
            if(!_model.getChipById(chip.itemID))
            {
               _model.bags[chip.position > 1000?chip.position:1].chips[chip.itemID] = chip;
            }
            else
            {
               delete _model.bags[_model.getChipById(chip.itemID).position > 1000?_model.getChipById(chip.itemID).position:1].chips[chip.itemID];
               if(chip.isExist)
               {
                  _model.bags[chip.position > 1000?chip.position:1].chips[chip.itemID] = chip;
               }
            }
            n++;
         }
         dispatchEvent(new MarkEvent("updateChips"));
      }
      
      private function __auctionGetMarkTips(e:PkgEvent) : void
      {
      }
      
      public function showMarkView(parent:DisplayObjectContainer, info:PlayerInfo = null) : void
      {
         parent = parent;
         info = info;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkSetLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkHammerLoader());
         AssetModuleLoader.addModelLoader("mark",7);
         AssetModuleLoader.startCodeLoader(function():void
         {
            var leftView:* = null;
            var rightView:* = null;
            var otherView:* = null;
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
                  leftView = ComponentFactory.Instance.creatCustomObject("mark.leftView");
                  _markContainer.addChild(leftView);
                  rightView = ComponentFactory.Instance.creatCustomObject("mark.rightView");
                  _markContainer.addChild(rightView);
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
                  otherView = ComponentFactory.Instance.creatCustomObject("mark.otherView",[info]);
                  _otherContainer.addChild(otherView);
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
      
      public function setMarkChipTempalte(analyzer:MarkChipAnalyzer) : void
      {
         _model.cfgChip = analyzer.chips;
      }
      
      public function setMarkSuitTempalte(analyzer:MarkSuitAnalyzer) : void
      {
         _model.cfgSuit = analyzer.suits;
      }
      
      public function setMarkProInfo(analyzer:MarkProAnalyzer) : void
      {
         _model.proNumInfoArr = analyzer.proNumDic;
      }
      
      public function setMarkSetTempalte(analyzer:MarkSetAnalyzer) : void
      {
         _model.cfgSet = analyzer.sets;
      }
      
      public function setMarkHammerTempalte(analyzer:MarkHammerAnalyzer) : void
      {
         _model.cfgHammer = analyzer.hammers;
      }
      
      public function setMarkTransferTempalte(analyzer:MarkTransferAnalyzer) : void
      {
         _model.cfgTransfer = analyzer.transfers;
      }
      
      public function showMarkMainFrame() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkProInfoLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkHammerLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createMarkTransferLoader());
         AssetModuleLoader.startCodeLoader(function():void
         {
            var frame:* = ComponentFactory.Instance.creatCustomObject("mark.mainFrame");
            LayerManager.Instance.addToLayer(frame,3,false,1);
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
      
      public function chooseEquip(index:int) : void
      {
         _model.equip = MarkModel.EQUIP_LIST[index];
         dispatchEvent(new MarkEvent("choose_equip"));
      }
      
      public function getEquipList() : Array
      {
         var i:int = 0;
         var list:Array = [];
         for(i = 0; i < MarkModel.EQUIP_LIST.length; )
         {
            list.push(PlayerManager.Instance.Self.Bag.items[MarkModel.EQUIP_LIST[i]]);
            i++;
         }
         return list;
      }
      
      public function checkTip(catergyId:int, place:int) : Boolean
      {
         if(place == 0 && catergyId == 1 || place == 2 && catergyId == 3 || place == 3 && catergyId == 4 || place == 5 && catergyId == 6 || place == 11 && catergyId == 13 || place == 4 && catergyId == 5)
         {
            return true;
         }
         return false;
      }
      
      public function reqOperationStatus(type:int, id:int) : void
      {
         SocketManager.Instance.out.sendOperationStatus(type,id);
         var list:Array = _model.newSuits;
         var index:int = list.indexOf(id);
         if(index > -1)
         {
            list.splice(index,1);
         }
         dispatchEvent(new MarkEvent("updateOperation"));
      }
      
      public function getHammerData(lv:int, charater:int) : MarkHammerTemplateData
      {
         var i:int = 0;
         lv = Math.min(lv + 1,getHammerTopLv(charater));
         var data:MarkHammerTemplateData = null;
         for(i = 0; i < _model.cfgHammer.length; )
         {
            data = _model.cfgHammer[i];
            if(data.Character == charater && data.Level == lv)
            {
               return data;
            }
            i++;
         }
         return null;
      }
      
      public function getHammerTopLv(charater:int) : int
      {
         var i:int = 0;
         var lv:int = 0;
         for(i = 0; i < _model.cfgHammer.length; )
         {
            if(_model.cfgHammer[i].Character == charater && _model.cfgHammer[i].Level >= lv)
            {
               lv = _model.cfgHammer[i].Level;
            }
            i++;
         }
         return lv;
      }
      
      public function getTransferData(charater:int, starLv:int) : MarkTransferTemplateData
      {
         var i:int = 0;
         var data:MarkTransferTemplateData = null;
         for(i = 0; i < _model.cfgTransfer.length; )
         {
            data = _model.cfgTransfer[i];
            if(data.Character == charater && data.Grade == starLv)
            {
               return data;
            }
            i++;
         }
         return null;
      }
      
      public function getAttributeAdd(id:int, type:int) : int
      {
         var chipTemplateData:MarkChipTemplateData = _model.cfgChip[id];
         if(!chipTemplateData)
         {
            return 0;
         }
         var proValue:int = 0;
         var _loc5_:* = type;
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
                                                   proValue = chipTemplateData.AttributeAdd14;
                                                }
                                             }
                                             else
                                             {
                                                proValue = chipTemplateData.AttributeAdd13;
                                             }
                                          }
                                          else
                                          {
                                             proValue = chipTemplateData.AttributeAdd12;
                                          }
                                       }
                                       else
                                       {
                                          proValue = chipTemplateData.AttributeAdd11;
                                       }
                                    }
                                    else
                                    {
                                       proValue = chipTemplateData.AttributeAdd10;
                                    }
                                 }
                                 else
                                 {
                                    proValue = chipTemplateData.AttributeAdd9;
                                 }
                              }
                              else
                              {
                                 proValue = chipTemplateData.AttributeAdd8;
                              }
                           }
                           else
                           {
                              proValue = chipTemplateData.AttributeAdd7;
                           }
                        }
                        else
                        {
                           proValue = chipTemplateData.AttributeAdd6;
                        }
                     }
                     else
                     {
                        proValue = chipTemplateData.AttributeAdd5;
                     }
                  }
                  else
                  {
                     proValue = chipTemplateData.AttributeAdd4;
                  }
               }
               else
               {
                  proValue = chipTemplateData.AttributeAdd3;
               }
            }
            else
            {
               proValue = chipTemplateData.AttributeAdd2;
            }
         }
         else
         {
            proValue = chipTemplateData.AttributeAdd1;
         }
         return int(proValue * 0.1 * (_model.getChipById(_model.chipItemID).hLv + 1));
      }
      
      public function getMarkProValue(chip:MarkChipData, type:int) : int
      {
         var proValue:int = 0;
         if(chip.mainPro.type == type)
         {
            proValue = proValue + (chip.mainPro.value + chip.mainPro.attachValue);
         }
         var _loc6_:int = 0;
         var _loc5_:* = chip.props;
         for each(var pro in chip.props)
         {
            if(pro.type == type)
            {
               proValue = proValue + (pro.value + pro.attachValue);
            }
         }
         return proValue;
      }
      
      public function checkMarkOpen(info:PlayerInfo = null) : Boolean
      {
         info = !!info?info:PlayerManager.Instance.Self;
         return info.Grade >= ServerConfigManager.instance.markOpenLevel;
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
         var i:int = 0;
         if(_model.sellList == null || _model.sellList.length == 0)
         {
            return 0;
         }
         var demand:int = 0;
         for(i = 0; i < _model.sellList.length; )
         {
            demand = demand + calculateDemand(_model.sellList[i]);
            i++;
         }
         return demand;
      }
      
      private function calculateDemand(id:int) : int
      {
         var lv:int = 0;
         var demand:int = 0;
         var data:MarkChipData = _model.getChipById(id);
         var itemData:ItemTemplateInfo = ItemManager.Instance.getTemplateById(data.templateId);
         var chipData:MarkChipTemplateData = _model.cfgChip[data.templateId];
         demand = demand + itemData.ReclaimValue;
         demand = demand + data.bornLv * ServerConfigManager.instance.EngraveSaleStarConfig;
         var hammerDemand:int = 0;
         var hammerData:MarkHammerTemplateData = null;
         for(lv = 0; lv < data.hLv; )
         {
            hammerData = getHammerData(lv,chipData.Character);
            if(hammerData)
            {
               hammerDemand = hammerDemand + hammerData.Expend;
            }
            lv++;
         }
         demand = demand + hammerDemand * ServerConfigManager.instance.EngraveSaleTemperConsumeConfig / 100;
         return demand;
      }
      
      private function alertHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",alertHandler);
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               if(alert == _sellAlert)
               {
                  _model.sellList.length = 0;
                  MarkMgr.inst.dispatchEvent(new MarkEvent("cancelSell"));
                  break;
               }
               break;
            case 2:
            case 3:
            case 4:
               if(alert == _alert)
               {
                  SocketManager.Instance.out.sendSubmitTransfer(1);
               }
               else if(alert == _sellAlert)
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
         alert.dispose();
         alert = null;
      }
      
      private function alertSecondHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",alertSecondHandler);
         switch(int(evt.responseCode))
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
         alert.dispose();
         alert = null;
      }
      
      public function submitHighStarSell() : void
      {
         _sellAlert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("mark.Single.highStar.sell"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1,null,"OneLineTxtAlert");
         _sellAlert.addEventListener("response",alertSecondHandler);
      }
      
      public function sortedProps(props:Dictionary) : Array
      {
         var arr:Array = [null,null,null,null,null,null,null,null,null,null,null,null,null,null];
         var rules:Array = [31,32,33,34,101,102,36,35,37,9,1,3,7,5];
         var index:int = -1;
         var _loc7_:int = 0;
         var _loc6_:* = props;
         for each(var it in props)
         {
            index = rules.indexOf(it.type);
            if(index > -1)
            {
               arr[index] = it;
            }
         }
         return arr;
      }
      
      public function getEquipProps() : Dictionary
      {
         return calculateEquipProps(_model.equip);
      }
      
      public function calculateEquipProps(place:int) : Dictionary
      {
         var i:int = 0;
         var chip:* = null;
         var dic:Dictionary = new Dictionary();
         var pro:MarkProData = null;
         for(i = 0; i < _model.getChipsByEquipType(place).length; )
         {
            chip = _model.getChipsByEquipType(place)[i];
            if(chip)
            {
               pro = chip.mainPro;
               if(!dic.hasOwnProperty(pro.type))
               {
                  dic[pro.type] = new MarkProData();
               }
               dic[pro.type].type = chip.mainPro.type;
               dic[pro.type].value = dic[pro.type].value + pro.value;
               dic[pro.type].attachValue = dic[pro.type].attachValue + pro.attachValue;
               var _loc8_:int = 0;
               var _loc7_:* = chip.props;
               for each(var item in chip.props)
               {
                  if(!dic.hasOwnProperty(item.type))
                  {
                     dic[item.type] = new MarkProData();
                  }
                  dic[item.type].type = item.type;
                  dic[item.type].value = dic[item.type].value + item.value;
                  dic[item.type].attachValue = dic[item.type].attachValue + item.attachValue;
               }
            }
            i++;
         }
         return dic;
      }
      
      private function __resSyncOrUpdateChips(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var chip:* = null;
         var isExist:Boolean = false;
         var mainPro:* = null;
         var j:int = 0;
         var subPro:* = null;
         var bag:MarkBagData = new MarkBagData();
         bag.type = pkg.pkg.readInt();
         var count:int = pkg.pkg.readInt();
         for(i = 0; i < count; )
         {
            chip = new MarkChipData();
            chip.itemID = pkg.pkg.readInt();
            chip.templateId = pkg.pkg.readInt();
            chip.position = pkg.pkg.readInt();
            isExist = pkg.pkg.readBoolean();
            if(!isExist)
            {
               pkg.pkg.readBoolean();
            }
            else
            {
               pkg.pkg.readBoolean();
               chip.isbind = pkg.pkg.readBoolean();
               chip.bornLv = pkg.pkg.readInt();
               chip.hammerLv = pkg.pkg.readInt();
               chip.hLv = pkg.pkg.readInt();
               mainPro = new MarkProData();
               mainPro.type = pkg.pkg.readInt();
               mainPro.value = pkg.pkg.readInt();
               mainPro.attachValue = pkg.pkg.readInt();
               chip.mainPro = mainPro;
               chip.props = new Vector.<MarkProData>();
               for(j = 0; j < 4; )
               {
                  subPro = new MarkProData();
                  subPro.type = pkg.pkg.readInt();
                  subPro.value = pkg.pkg.readInt();
                  subPro.attachValue = pkg.pkg.readInt();
                  subPro.hummerCount = pkg.pkg.readInt();
                  chip.props.push(subPro);
                  j++;
               }
               bag.chips[chip.itemID] = chip;
            }
            i++;
         }
         _model.bags[bag.type] = bag;
      }
      
      public function reqSyncOrUpdateChips() : void
      {
         SocketManager.Instance.out.sendUserAllDebris();
      }
      
      public function moveChip(id:int) : void
      {
         var index:int = 0;
         if(checkChipExist(id))
         {
            index = MarkModel.EQUIP_LIST.indexOf(_model.equip) + 1;
            SocketManager.Instance.out.sendOnOrOffChip(id,index);
         }
      }
      
      private function checkChipExist(itemId:int) : Boolean
      {
         if(!_model.getChipById(itemId))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error1"));
            return false;
         }
         return true;
      }
      
      public function reqSellChips() : void
      {
         var arr:Array = _model.sellList;
         if(!arr || arr.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error4"));
         }
         else
         {
            SocketManager.Instance.out.sendSellChips(arr);
         }
         MarkMgr.inst.dispatchEvent(new MarkEvent("cancelSell"));
      }
      
      private function __resHammerChip(pkg:PkgEvent) : void
      {
         var result:Boolean = pkg.pkg.readBoolean();
         var id:int = pkg.pkg.readInt();
         var cnt:int = pkg.pkg.readInt();
         dispatchEvent(new MarkEvent("hammerResult",{
            "result":result,
            "cnt":cnt - 1
         }));
      }
      
      public function reqHammerChip(cnt:int = 1) : void
      {
         var chip:* = null;
         var data:* = null;
         if(checkChipExist(_model.chipItemID))
         {
            chip = _model.getChipById(_model.chipItemID);
            data = getHammerData(chip.hLv,_model.cfgChip[chip.templateId].Character);
            if(data.Expend > _model.markMoney)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error5"));
               return;
            }
            if(chip.hLv >= getHammerTopLv(_model.cfgChip[chip.templateId].Character))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error6"));
               return;
            }
            SocketManager.Instance.out.sendHammerChip(_model.chipItemID,cnt);
         }
      }
      
      private function __resMarkMoney(pkg:PkgEvent) : void
      {
         _model.markMoney = pkg.pkg.readInt();
         dispatchEvent(new MarkEvent("markMoney"));
      }
      
      public function reqTransferChip(proKey:int) : void
      {
         var chip:* = null;
         var item:* = null;
         var transferData:* = null;
         if(checkChipExist(_model.chipItemID))
         {
            if(verfyPro(proKey))
            {
               chip = _model.getChipById(_model.chipItemID);
               item = ItemManager.Instance.getTemplateById(chip.templateId);
               transferData = this.getTransferData(item.Quality,chip.bornLv + chip.hammerLv);
               if(transferData.Expend > _model.markMoney)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error9"));
                  return;
               }
               if(transferData.NeedMaterial > PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12200))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error10"));
                  return;
               }
               SocketManager.Instance.out.sendTransferChip(_model.chipItemID,proKey);
            }
         }
      }
      
      private function verfyPro(proKey:int) : Boolean
      {
         var exist:Boolean = false;
         var i:int = 0;
         var chip:MarkChipData = _model.getChipById(_model.chipItemID);
         if(chip)
         {
            exist = false;
            i = 0;
            while(chip.props && i < chip.props.length)
            {
               if(chip.props[i].type == proKey)
               {
                  return true;
               }
               i++;
            }
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("mark.error8"));
         return false;
      }
      
      private function __resTransferChip(pkg:PkgEvent) : void
      {
         var pro:MarkProData = new MarkProData();
         var id:int = pkg.pkg.readInt();
         var oType:int = pkg.pkg.readInt();
         pro.type = pkg.pkg.readInt();
         pro.value = pkg.pkg.readInt();
         pro.hummerCount = pkg.pkg.readInt();
         _model.transferPro = pro;
         dispatchEvent(new MarkEvent("transferResult"));
      }
      
      public function reqTransferSubmit(submit:Boolean = true) : void
      {
         if(!submit)
         {
            submitTransfer();
         }
         else
         {
            SocketManager.Instance.out.sendSubmitTransfer(0);
         }
      }
      
      private function __resTransferSubmit(pkg:PkgEvent) : void
      {
         var result:Boolean = pkg.pkg.readBoolean();
         _model.transferPro = null;
         dispatchEvent(new MarkEvent("submitResult"));
      }
      
      private function __resOperationStatus(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var type:int = pkg.pkg.readInt();
         var list:Array = _model.newSuits;
         list.length = 0;
         var cnt:int = pkg.pkg.readInt();
         for(i = 0; i < cnt; )
         {
            list.push(pkg.pkg.readInt());
            i++;
         }
         dispatchEvent(new MarkEvent("updateOperation"));
      }
      
      protected function __onVaultsData(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var arr:Array = [];
         var freeTimeNum:Number = pkg.readLong();
         arr.push(freeTimeNum);
         var useFreeNum:int = pkg.readInt();
         arr.push(useFreeNum);
         dispatchEvent(new MarkEvent("vaultsData",arr));
      }
      
      protected function __onVaultsReward(e:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var templateID:int = 0;
         var info:* = null;
         var logoId:int = 0;
         var pkg:PackageIn = e.pkg;
         var type:int = pkg.readInt();
         isFull = pkg.readBoolean();
         if(!isFull)
         {
            count = pkg.readInt();
            treasureRoomRewardArr = [];
            treasureRoomLogoIdArr = [];
            for(i = 0; i < count; )
            {
               templateID = pkg.readInt();
               info = ItemManager.fillByID(templateID);
               info.Count = pkg.readInt();
               treasureRoomRewardArr.push(info);
               logoId = pkg.readInt();
               treasureRoomLogoIdArr.push(logoId);
               i++;
            }
         }
         dispatchEvent(new MarkEvent("vaultsReward",type));
      }
      
      public function get schemeModel() : MarkSchemeModel
      {
         return _schemeModel;
      }
      
      public function isCanSellByDebrisID(id:int) : Boolean
      {
         var schemes:String = _schemeModel.getAllSchemeData;
         var temStr:String = "," + id + ",";
         return schemes.indexOf(temStr) == -1;
      }
      
      public function checkEquipSchemeBagFull(schemeInfo:MarkSchemeInfo) : Boolean
      {
         var i:int = 0;
         var j:int = 0;
         var chip1Arr:Array = [];
         var chip2Arr:Array = [];
         var numArr:Array = [];
         var _loc11_:* = 0;
         var _loc10_:* = _model.cfgSet;
         for(var n in _model.cfgSet)
         {
            chip1Arr.push(0);
            chip2Arr.push(0);
            numArr.push(0);
         }
         var currentScheme:MarkSchemeInfo = _schemeModel.getSchemeInfo(_schemeModel.curScheme);
         for(i = 0; i < schemeInfo.chips.length; )
         {
            if(schemeInfo.chips[i] != 0)
            {
               if(_model.getSetById(schemeInfo.chips[i]) != 0)
               {
                  _loc11_ = _model.getSetById(schemeInfo.chips[i]) - 1001;
                  _loc10_ = chip1Arr[_loc11_] + 1;
                  chip1Arr[_loc11_] = _loc10_;
               }
            }
            if(currentScheme.chips[i] != 0)
            {
               if(_model.getSetById(currentScheme.chips[i]) != 0)
               {
                  _loc10_ = _model.getSetById(currentScheme.chips[i]) - 1001;
                  _loc11_ = chip2Arr[_loc10_] + 1;
                  chip2Arr[_loc10_] = _loc11_;
               }
            }
            i++;
         }
         var _loc13_:int = 0;
         var _loc12_:* = _model.bags;
         for each(var bag in _model.bags)
         {
            if(bag.type > 1)
            {
               numArr[bag.type - 1001] = bag.chipCnt;
            }
         }
         for(j = 0; j < chip2Arr.length; )
         {
            if(numArr[j] + chip2Arr[j] - chip1Arr[j] > 100)
            {
               return false;
            }
            j++;
         }
         return true;
      }
      
      public function reqSaveMarkScheme(schemeID:int) : void
      {
         SocketManager.Instance.out.sendSaveEquipScheme(schemeID);
      }
      
      public function reqSwitchEquipScheme(schemeID:int) : void
      {
         SocketManager.Instance.out.sendSwitchEquipScheme(schemeID);
      }
      
      public function reqAddEquipScheme() : void
      {
         SocketManager.Instance.out.sendAddEquipScheme();
      }
      
      public function promptSchemeSave(callFun:Function, params:int = -1) : void
      {
         callFun = callFun;
         params = params;
         var alertAsk:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("mark.switchScheme.noSave.tipMgs"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false,0);
         alertAsk.addEventListener("response",function():*
         {
            var /*UnknownSlot*/:* = function(evt:FrameEvent):void
            {
               var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
               frame.removeEventListener("response",__switchSchemeNoSave);
               SoundManager.instance.playButtonSound();
               switch(int(evt.responseCode) - 2)
               {
                  case 0:
                  case 1:
                     callFun.call(this,true);
               }
               frame.dispose();
            };
            return function(evt:FrameEvent):void
            {
               var frame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
               frame.removeEventListener("response",__switchSchemeNoSave);
               SoundManager.instance.playButtonSound();
               switch(int(evt.responseCode) - 2)
               {
                  case 0:
                  case 1:
                     callFun.call(this,true);
               }
               frame.dispose();
            };
         }());
      }
      
      protected function __resEquipScheme(evt:PkgEvent) : void
      {
         var data:* = null;
         var schemeInfo:* = null;
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         _schemeModel.clearScheme();
         for(i = 0; i < 5; )
         {
            data = pkg.readUTF();
            schemeInfo = new MarkSchemeInfo(i,data);
            _schemeModel.updateScheme(i,schemeInfo);
            i++;
         }
         var curScheme:int = pkg.readInt();
         _schemeModel.curScheme = curScheme;
         _schemeModel.schemCount = pkg.readInt();
      }
      
      protected function __resAddEquipScheme(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _schemeModel.schemCount = pkg.readInt();
         var schemData:String = pkg.readUTF();
         var schemeInfo:MarkSchemeInfo = new MarkSchemeInfo(_schemeModel.schemCount - 1,schemData);
         _schemeModel.updateScheme(_schemeModel.schemCount - 1,schemeInfo);
         this.dispatchEvent(new MarkEvent("addScheme"));
      }
      
      protected function __resSwitchEquipScheme(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var schemeID:int = pkg.readInt();
         var result:Boolean = pkg.readBoolean();
         if(result)
         {
            _schemeModel.curScheme = schemeID;
            dispatchEvent(new MarkEvent("curSchemeChange"));
         }
         else
         {
            dispatchEvent(new MarkEvent("curSchemeChangeDEF"));
         }
      }
      
      protected function __resSaveScheme(evt:PkgEvent) : void
      {
         var schemeInfo:* = null;
         var pkg:PackageIn = evt.pkg;
         var schemeID:int = pkg.readInt();
         var result:Boolean = pkg.readBoolean();
         var schemData:String = pkg.readUTF();
         if(result)
         {
            schemeInfo = new MarkSchemeInfo(schemeID,schemData);
            _schemeModel.updateScheme(schemeID,schemeInfo);
            this.dispatchEvent(new MarkEvent("saveScheme"));
         }
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
