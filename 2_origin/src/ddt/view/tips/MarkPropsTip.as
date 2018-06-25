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
      
      public function MarkPropsTip(place:int)
      {
         super();
         _place = place;
         _tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
         addChild(_tipbackgound);
         var tipTile:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("core.mark.Props");
         tipTile.text = LanguageMgr.GetTranslation("mark.propsTipTile");
         addChild(tipTile);
         _propCnt = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropsCnt");
         addChild(_propCnt);
         _propCnt.x = tipTile.x + tipTile.textWidth + 5;
         var line1:Image = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         PositionUtils.setPos(line1,"markTip.linePos");
         addChild(line1);
      }
      
      public function set data(info:PlayerInfo) : void
      {
         var idx:int = 0;
         var name:* = null;
         var value:* = null;
         var name1:* = null;
         var value1:* = null;
         _propCnt.text = LanguageMgr.GetTranslation("mark.propCnt",info.getMarkChipCntByPlace(_place));
         var offsetY:int = 39;
         var props:Dictionary = info.getMarkChipPropsByPlace(_place);
         var sortedProps:Array = MarkMgr.inst.sortedProps(props);
         var pro:MarkProData = null;
         for(idx = 0; idx < sortedProps.length; )
         {
            pro = sortedProps[idx] as MarkProData;
            if(pro != null)
            {
               name = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtName");
               name.text = LanguageMgr.GetTranslation("mark.propertyName",LanguageMgr.GetTranslation("mark.pro" + pro.type));
               value = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtValue");
               value.htmlText = LanguageMgr.GetTranslation("mark.propertyValue",pro.value + pro.attachValue);
               PositionUtils.setPos(name,{
                  "x":7,
                  "y":offsetY
               });
               PositionUtils.setPos(value,{
                  "x":name.x + name.textWidth + 3,
                  "y":offsetY
               });
               addChild(name);
               addChild(value);
               offsetY = offsetY + (value.textHeight + 4);
            }
            idx++;
         }
         var line2:Image = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         PositionUtils.setPos(line2,{
            "x":5,
            "y":offsetY
         });
         addChild(line2);
         offsetY = offsetY + 7;
         var suits:Array = info.getSuitListByPlace(_place);
         var _loc15_:int = 0;
         var _loc14_:* = MarkMgr.inst.model.cfgSuit;
         for each(var it in MarkMgr.inst.model.cfgSuit)
         {
            if(suits.indexOf(it.Id) > -1)
            {
               name1 = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtName");
               name1.text = it.Name + "：";
               value1 = ComponentFactory.Instance.creatComponentByStylename("core.mark.PropTxtValue");
               value1.htmlText = it.Explain;
               PositionUtils.setPos(name1,{
                  "x":7,
                  "y":offsetY
               });
               PositionUtils.setPos(value1,{
                  "x":name1.x + name1.textWidth + 3,
                  "y":offsetY
               });
               addChild(name1);
               addChild(value1);
               offsetY = offsetY + (value1.textHeight + 4);
            }
         }
         _tipbackgound.height = offsetY + 8;
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
