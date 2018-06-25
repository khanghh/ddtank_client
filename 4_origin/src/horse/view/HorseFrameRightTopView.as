package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.HorseManager;
   import horse.data.HorseAmuletVo;
   import horse.data.HorseTemplateVo;
   import horse.horsePicCherish.HorsePicCherishFrame;
   
   public class HorseFrameRightTopView extends Sprite implements Disposeable
   {
       
      
      private var _addPropertyValueTxtList:Vector.<FilterFrameText>;
      
      private var _addSecondPropertyValueTxtList:Vector.<FilterFrameText>;
      
      public function HorseFrameRightTopView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var nameTxt:* = null;
         var valueTxt:* = null;
         var j:int = 0;
         var secondName:* = null;
         var secondValueTxt:* = null;
         _addPropertyValueTxtList = new Vector.<FilterFrameText>();
         _addSecondPropertyValueTxtList = new Vector.<FilterFrameText>();
         var nameStrList:Array = LanguageMgr.GetTranslation("horse.addPropertyNameStr").split(",");
         for(i = 0; i < 5; )
         {
            nameTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyNameTxt");
            nameTxt.text = nameStrList[i];
            nameTxt.y = 38 + int(i / 2) * 29;
            nameTxt.x = 455 + 161 * (i % 2);
            valueTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyValueTxt");
            valueTxt.text = "0";
            valueTxt.y = 38 + int(i / 2) * 29;
            valueTxt.x = 554 + 135 * (i % 2);
            _addPropertyValueTxtList.push(valueTxt);
            addChild(nameTxt);
            addChild(valueTxt);
            i++;
         }
         var secondNameList:Array = LanguageMgr.GetTranslation("tank.horseAmulet.propertyList").split(",");
         for(j = 0; j < 9; )
         {
            secondName = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addSecondPorpertyNameTxt");
            secondName.text = secondNameList[j];
            secondName.y = 177 + int(j / 3) * 29;
            secondName.x = 442 + 105 * (j % 3);
            secondValueTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyValueTxt");
            secondValueTxt.y = 177 + int(j / 3) * 29;
            secondValueTxt.x = 511 + 101 * (j % 3);
            _addSecondPropertyValueTxtList.push(secondValueTxt);
            addChild(secondName);
            addChild(secondValueTxt);
            j++;
         }
         updateSelfTips();
      }
      
      public function updateSelfTips() : void
      {
         var hp:int = 0;
         var i:int = 0;
         var info:* = null;
         var vo:* = null;
         var j:int = 0;
         var key:* = null;
         var p:int = 0;
         var bag:BagInfo = PlayerManager.Instance.Self.horseAmuletBag;
         var data:Dictionary = new Dictionary();
         for(i = 0; i < 9; )
         {
            info = bag.getItemAt(i) as InventoryItemInfo;
            if(info)
            {
               vo = HorseAmuletManager.instance.getHorseAmuletVo(info.TemplateID);
               hp = hp + vo.BaseType1Value;
               if(data[vo.ExtendType1])
               {
                  var _loc10_:* = vo.ExtendType1;
                  var _loc11_:* = data[_loc10_] + info.Hole1;
                  data[_loc10_] = _loc11_;
               }
               else
               {
                  data[vo.ExtendType1] = info.Hole1;
               }
            }
            i++;
         }
         for(j = 0; j < 9; )
         {
            key = (j + 1).toString();
            p = data[key] || 0;
            _addSecondPropertyValueTxtList[j].text = String(p);
            j++;
         }
      }
      
      private function initEvent() : void
      {
         HorseManager.instance.addEventListener("horseUpHorseStep2",upHorseHandler);
         HorseManager.instance.addEventListener("horsePreNextEffect",refreshNextView);
         HorseManager.instance.addEventListener("horseRefreshCurEffect",refreshView);
      }
      
      private function upHorseHandler(event:Event) : void
      {
         refreshView();
      }
      
      private function skillClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:HorseSkillFrame = ComponentFactory.Instance.creatComponentByStylename("HorseSkillFrame");
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
      
      private function picClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:HorsePicCherishFrame = ComponentFactory.Instance.creatComponentByStylename("HorsePicCherishFrame");
         frame.index = 1;
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
      
      private function __onAmuletHandler(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 31)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",31));
            return;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(141))
         {
            SocketManager.Instance.out.syncWeakStep(141);
         }
      }
      
      private function refreshView(event:Event = null) : void
      {
         var tmp:HorseTemplateVo = HorseManager.instance.curHorseTemplateInfo;
         _addPropertyValueTxtList[0].text = tmp.AddDamage.toString();
         _addPropertyValueTxtList[1].text = tmp.AddGuard.toString();
         _addPropertyValueTxtList[2].text = tmp.AddBlood.toString();
         _addPropertyValueTxtList[3].text = tmp.MagicAttack.toString();
         _addPropertyValueTxtList[4].text = tmp.MagicDefence.toString();
      }
      
      private function refreshNextView(event:Event = null) : void
      {
         var curLevel:int = HorseManager.instance.curLevel;
         var nextBigLevel:int = (int(curLevel / 10) + 1) * 10;
         var tmp:HorseTemplateVo = HorseManager.instance.getHorseTemplateInfoByLevel(nextBigLevel);
         if(!tmp)
         {
            return;
         }
         _addPropertyValueTxtList[0].text = tmp.AddDamage.toString();
         _addPropertyValueTxtList[1].text = tmp.AddGuard.toString();
         _addPropertyValueTxtList[2].text = tmp.AddBlood.toString();
         _addPropertyValueTxtList[3].text = tmp.MagicAttack.toString();
         _addPropertyValueTxtList[4].text = tmp.MagicDefence.toString();
         _addPropertyValueTxtList[0].textColor = 15216382;
         _addPropertyValueTxtList[1].textColor = 15216382;
         _addPropertyValueTxtList[2].textColor = 15216382;
         _addPropertyValueTxtList[3].textColor = 15216382;
         _addPropertyValueTxtList[4].textColor = 15216382;
      }
      
      private function removeEvent() : void
      {
         HorseManager.instance.removeEventListener("horseUpHorseStep2",upHorseHandler);
         HorseManager.instance.removeEventListener("horsePreNextEffect",refreshNextView);
         HorseManager.instance.removeEventListener("horseRefreshCurEffect",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _addPropertyValueTxtList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
