package texpSystem.view
{
   import bagAndInfo.tips.CharacterPropTxtTipInfo;
   import bagAndInfo.tips.CharacterSecondProTxtTip;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   
   public class TexpInfoTipArea extends Sprite implements Disposeable
   {
       
      
      private var _tip:CharacterSecondProTxtTip;
      
      private var _info:PlayerInfo;
      
      public function TexpInfoTipArea()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         addEventListener("rollOver",__over);
         addEventListener("rollOut",__out);
         var size:Point = ComponentFactory.Instance.creatCustomObject("texpSystem.texpInfoTipArea.size");
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,size.x,size.y);
         graphics.endFill();
         _tip = ComponentFactory.Instance.creatComponentByStylename("core.ChatacterSecondPropTips");
         var tipInfo:CharacterPropTxtTipInfo = new CharacterPropTxtTipInfo();
         tipInfo.color = 0;
         tipInfo.detail = LanguageMgr.GetTranslation("ddt.bagandinfo.secondProIconTipsDesc");
         tipInfo.property = LanguageMgr.GetTranslation("ddt.bagandinfo.secondProIconTxt");
         tipInfo.propertySource = LanguageMgr.GetTranslation("ddt.bagandinfo.secondProIconTipsConten",0,0,0,0,0,0,0,0,0);
         _tip.tipData = tipInfo;
      }
      
      public function set info(value:PlayerInfo) : void
      {
         var tipInfo:* = null;
         if(!value)
         {
            return;
         }
         _info = value;
         var damageDic:DictionaryData = _info.getPropertyAdditionByType("SecondPro");
         if(damageDic != null)
         {
            tipInfo = _tip.tipData as CharacterPropTxtTipInfo;
            tipInfo.propertySource = LanguageMgr.GetTranslation("ddt.bagandinfo.secondProIconTipsConten",damageDic["Crit"],damageDic["Tenacity"],damageDic["SunderArmor"],damageDic["AvoidInjury"],damageDic["Kill"],damageDic["WillFight"],damageDic["ViolenceInjury"],damageDic["Guard"],damageDic["Speed"]);
            _tip.tipData = tipInfo;
         }
      }
      
      private function __over(evt:MouseEvent) : void
      {
         var pos:* = null;
         if(!_tip.parent && _info)
         {
            pos = localToGlobal(new Point(0,0));
            _tip.x = pos.x;
            _tip.y = pos.y + width;
            LayerManager.Instance.addToLayer(_tip,2);
         }
      }
      
      private function __out(evt:MouseEvent) : void
      {
         if(_tip.parent)
         {
            _tip.parent.removeChild(_tip);
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("rollOver",__over);
         removeEventListener("rollOut",__out);
         ObjectUtils.disposeObject(_tip);
         _tip = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
