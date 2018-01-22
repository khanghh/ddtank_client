package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mark.MarkMgr;
   import mark.data.MarkProData;
   import mark.data.MarkSuitTemplateData;
   
   public class MarkPropsTip extends Sprite implements Disposeable
   {
       
      
      private var _tipbackgound:Image;
      
      private var _propCnt:FilterFrameText = null;
      
      private var _place:int = -1;
      
      public function MarkPropsTip(param1:int)
      {
         super();
         _place = param1;
         _tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
         addChild(_tipbackgound);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("core.mark.Props");
         _loc2_.text = LanguageMgr.GetTranslation("mark.propsTipTile");
         addChild(_loc2_);
         _propCnt = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropsCnt");
         addChild(_propCnt);
         _propCnt.x = _loc2_.x + _loc2_.textWidth + 5;
         var _loc3_:Image = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         PositionUtils.setPos(_loc3_,"markTip.linePos");
         addChild(_loc3_);
      }
      
      public function set data(param1:PlayerInfo) : void
      {
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc5_:* = null;
         _propCnt.text = LanguageMgr.GetTranslation("mark.propCnt",param1.getMarkChipCntByPlace(_place));
         var _loc4_:int = 39;
         var _loc11_:Dictionary = param1.getMarkChipPropsByPlace(_place);
         var _loc12_:Array = MarkMgr.inst.sortedProps(_loc11_);
         var _loc7_:MarkProData = null;
         _loc2_ = 0;
         while(_loc2_ < _loc12_.length)
         {
            _loc7_ = _loc12_[_loc2_] as MarkProData;
            if(_loc7_ != null)
            {
               _loc6_ = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtName");
               _loc6_.text = LanguageMgr.GetTranslation("mark.propertyName",LanguageMgr.GetTranslation("mark.pro" + _loc7_.type));
               _loc8_ = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtValue");
               _loc8_.htmlText = LanguageMgr.GetTranslation("mark.propertyValue",_loc7_.value + _loc7_.attachValue);
               PositionUtils.setPos(_loc6_,{
                  "x":7,
                  "y":_loc4_
               });
               PositionUtils.setPos(_loc8_,{
                  "x":_loc6_.x + _loc6_.textWidth + 3,
                  "y":_loc4_
               });
               addChild(_loc6_);
               addChild(_loc8_);
               _loc4_ = _loc4_ + (_loc8_.textHeight + 4);
            }
            _loc2_++;
         }
         var _loc13_:Image = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         PositionUtils.setPos(_loc13_,{
            "x":5,
            "y":_loc4_
         });
         addChild(_loc13_);
         _loc4_ = _loc4_ + 7;
         var _loc9_:Array = param1.getSuitListByPlace(_place);
         var _loc15_:int = 0;
         var _loc14_:* = MarkMgr.inst.model.cfgSuit;
         for each(var _loc3_ in MarkMgr.inst.model.cfgSuit)
         {
            if(_loc9_.indexOf(_loc3_.Id) > -1)
            {
               _loc10_ = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtName");
               _loc10_.text = _loc3_.Name + "：";
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtValue");
               _loc5_.htmlText = _loc3_.Explain;
               PositionUtils.setPos(_loc10_,{
                  "x":7,
                  "y":_loc4_
               });
               PositionUtils.setPos(_loc5_,{
                  "x":_loc10_.x + _loc10_.textWidth + 3,
                  "y":_loc4_
               });
               addChild(_loc10_);
               addChild(_loc5_);
               _loc4_ = _loc4_ + (_loc5_.textHeight + 4);
            }
         }
         _tipbackgound.height = _loc4_ + 8;
         _tipbackgound.width = 205;
      }
      
      override public function get height() : Number
      {
         return !!_tipbackgound?_tipbackgound.height:Number(super.height);
      }
      
      public function dispose() : void
      {
         _place = -1;
         if(_propCnt)
         {
            ObjectUtils.disposeObject(_propCnt);
         }
         _propCnt = null;
      }
   }
}
