package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.store.FineSuitVo;
   import ddt.manager.FineSuitManager;
   import ddt.manager.LanguageMgr;
   
   public class FineSuitTips extends BaseTip
   {
       
      
      private var _title:FilterFrameText;
      
      private var suitType:Array;
      
      private var _itemList:Vector.<FineSuitTipsItem>;
      
      private var _textList:Vector.<FilterFrameText>;
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      public function FineSuitTips()
      {
         suitType = LanguageMgr.GetTranslation("storeFine.suit.type").split(",");
         super();
      }
      
      override protected function init() : void
      {
         tipbackgound = ComponentFactory.Instance.creat("core.GoodsTipBg");
      }
      
      override protected function addChildren() : void
      {
         var i:int = 0;
         var item:* = null;
         var text:* = null;
         super.addChildren();
         ObjectUtils.copyPropertyByRectangle(_tipbackgound,ComponentFactory.Instance.creatCustomObject("ddtstore.tips.bgRect"));
         _title = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.title");
         _title.text = LanguageMgr.GetTranslation("storeFine.tips.titleText");
         addChild(_title);
         _line1 = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.line");
         addChild(_line1);
         _line2 = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.line");
         addChild(_line2);
         _itemList = new Vector.<FineSuitTipsItem>();
         _textList = new Vector.<FilterFrameText>();
         for(i = 0; i < 12; )
         {
            if(i < 5)
            {
               item = new FineSuitTipsItem();
               _itemList.push(item);
               addChild(item);
            }
            else
            {
               text = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.itemUnfold");
               _textList.push(text);
               addChild(text);
            }
            i++;
         }
      }
      
      override public function set tipData(data:Object) : void
      {
         if(_tipData == data)
         {
            return;
         }
         _tipData = data;
         updateTipsView();
      }
      
      private function updateTipsView() : void
      {
         var item:* = null;
         var i:int = 0;
         var j:int = 0;
         var text:* = null;
         var vo:FineSuitVo = FineSuitManager.Instance.getSuitVoByExp(int(_tipData));
         var type:int = vo.type == 0?1:vo.type;
         var level:int = vo.level;
         if(level > 14)
         {
            level = level == 0?0:Number(level % 14 == 0?14:Number(level % 14));
         }
         var textY:int = 43;
         _tipbackgound.width = 100;
         for(i = 0; i < 5; )
         {
            item = _itemList[i];
            item.titleText = LanguageMgr.GetTranslation("storeFine.tips.itemText",suitType[i]);
            item.text = FineSuitManager.Instance.getTipsPropertyInfoListToString(i + 1,"all");
            item.type = i + 1;
            item.complete = i + 1 < type || i == 4 && vo.level == 70;
            item.y = textY;
            textY = textY + item.height;
            setBackgoundWidth(item.width);
            if(i + 1 == type)
            {
               _line1.y = textY;
               textY = textY + 10;
               for(j = 0; j < 7; )
               {
                  text = _textList[j];
                  text.text = getItmeContent(j + 1,type);
                  text.setFrame(level >= (j + 1) * 2?1:2);
                  text.y = textY;
                  textY = textY + text.height;
                  setBackgoundWidth(text.width);
                  j++;
               }
               _line2.y = textY + 10;
               textY = textY + 20;
            }
            i++;
         }
         _tipbackgound.height = textY;
      }
      
      private function getItmeContent(i:int, type:int) : String
      {
         var level:String = (i * 2).toString();
         return "[" + suitType[type - 1] + "]" + "(" + level + "/14) " + FineSuitManager.Instance.getTipsPropertyInfoListToString(type,level);
      }
      
      private function setBackgoundWidth(value:int) : void
      {
         if(value + 20 > _tipbackgound.width)
         {
            _tipbackgound.width = value + 20;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _itemList = null;
         _textList = null;
         super.dispose();
      }
   }
}
