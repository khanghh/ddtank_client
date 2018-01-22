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
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
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
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            if(_loc3_ < 5)
            {
               _loc2_ = new FineSuitTipsItem();
               _itemList.push(_loc2_);
               addChild(_loc2_);
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("fineSuit.tips.itemUnfold");
               _textList.push(_loc1_);
               addChild(_loc1_);
            }
            _loc3_++;
         }
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(_tipData == param1)
         {
            return;
         }
         _tipData = param1;
         updateTipsView();
      }
      
      private function updateTipsView() : void
      {
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc8_:FineSuitVo = FineSuitManager.Instance.getSuitVoByExp(int(_tipData));
         var _loc6_:int = _loc8_.type == 0?1:_loc8_.type;
         var _loc2_:int = _loc8_.level;
         if(_loc2_ > 14)
         {
            _loc2_ = _loc2_ == 0?0:Number(_loc2_ % 14 == 0?14:Number(_loc2_ % 14));
         }
         var _loc4_:int = 43;
         _tipbackgound.width = 100;
         _loc7_ = 0;
         while(_loc7_ < 5)
         {
            _loc3_ = _itemList[_loc7_];
            _loc3_.titleText = LanguageMgr.GetTranslation("storeFine.tips.itemText",suitType[_loc7_]);
            _loc3_.text = FineSuitManager.Instance.getTipsPropertyInfoListToString(_loc7_ + 1,"all");
            _loc3_.type = _loc7_ + 1;
            _loc3_.complete = _loc7_ + 1 < _loc6_ || _loc7_ == 4 && _loc8_.level == 70;
            _loc3_.y = _loc4_;
            _loc4_ = _loc4_ + _loc3_.height;
            setBackgoundWidth(_loc3_.width);
            if(_loc7_ + 1 == _loc6_)
            {
               _line1.y = _loc4_;
               _loc4_ = _loc4_ + 10;
               _loc5_ = 0;
               while(_loc5_ < 7)
               {
                  _loc1_ = _textList[_loc5_];
                  _loc1_.text = getItmeContent(_loc5_ + 1,_loc6_);
                  _loc1_.setFrame(_loc2_ >= (_loc5_ + 1) * 2?1:2);
                  _loc1_.y = _loc4_;
                  _loc4_ = _loc4_ + _loc1_.height;
                  setBackgoundWidth(_loc1_.width);
                  _loc5_++;
               }
               _line2.y = _loc4_ + 10;
               _loc4_ = _loc4_ + 20;
            }
            _loc7_++;
         }
         _tipbackgound.height = _loc4_;
      }
      
      private function getItmeContent(param1:int, param2:int) : String
      {
         var _loc3_:String = (param1 * 2).toString();
         return "[" + suitType[param2 - 1] + "]" + "(" + _loc3_ + "/14) " + FineSuitManager.Instance.getTipsPropertyInfoListToString(param2,_loc3_);
      }
      
      private function setBackgoundWidth(param1:int) : void
      {
         if(param1 + 20 > _tipbackgound.width)
         {
            _tipbackgound.width = param1 + 20;
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
