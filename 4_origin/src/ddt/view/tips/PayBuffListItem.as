package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class PayBuffListItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:DisplayObject;
      
      private var _labelField:FilterFrameText;
      
      private var _timeField:FilterFrameText;
      
      private var _w:int;
      
      private var _h:int;
      
      private var _countField:FilterFrameText;
      
      private var levelDic:Dictionary;
      
      private var fightBuffClass;
      
      public function PayBuffListItem(param1:*)
      {
         levelDic = new Dictionary();
         super();
         initLevelDic();
         var _loc2_:String = "";
         if(param1 is BuffInfo)
         {
            _loc2_ = "asset.core.payBuffAsset" + param1.Type;
         }
         else
         {
            fightBuffClass = getDefinitionByName("gameCommon.model.FightBuffInfo");
            if(fightBuffClass && param1 is fightBuffClass)
            {
               _loc2_ = "asset.game.buff" + param1.displayid;
            }
         }
         _icon = addChild(ComponentFactory.Instance.creatBitmap(_loc2_));
         var _loc3_:Point = ComponentFactory.Instance.creatCustomObject("asset.core.PayBuffIconSize");
         _icon.width = _loc3_.x;
         _icon.height = _loc3_.y;
         _labelField = ComponentFactory.Instance.creatComponentByStylename("asset.core.PayBuffTipLabel");
         _labelField.text = param1.buffName;
         addChild(_labelField);
         if(param1 is BuffInfo)
         {
            _countField = ComponentFactory.Instance.creatComponentByStylename("asset.core.PayBuffTipCount");
            if(param1.maxCount > 0 && param1.isSelf)
            {
               _countField.text = param1.ValidCount + "/" + param1.maxCount;
            }
            addChild(_countField);
            _timeField = ComponentFactory.Instance.creatComponentByStylename("asset.core.PayBuffTipTime");
            _timeField.text = LanguageMgr.GetTranslation("tank.view.buff.VipLevelFree",levelDic[param1.Type]);
            addChild(_timeField);
            _w = _timeField.x + _timeField.width;
         }
         else
         {
            _timeField = ComponentFactory.Instance.creatComponentByStylename("asset.core.PayBuffTipTime");
            _timeField.text = fightBuffClass(param1).description;
            addChild(_timeField);
            _timeField.x = _labelField.x + _labelField.textWidth + 15;
            _w = _timeField.x + _timeField.width;
         }
         _h = _icon.height;
      }
      
      private function initLevelDic() : void
      {
         levelDic[50] = "7";
         levelDic[51] = "4";
         levelDic[52] = "6";
         levelDic[71] = "8";
         levelDic[72] = "3";
         levelDic[73] = "5";
         levelDic[70] = "9";
      }
      
      override public function get width() : Number
      {
         return _w;
      }
      
      override public function get height() : Number
      {
         return _h;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_labelField);
         _labelField = null;
         ObjectUtils.disposeObject(_timeField);
         _timeField = null;
         ObjectUtils.disposeObject(_countField);
         _countField = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
