package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import totem.TotemManager;
   import totem.data.TotemAddInfo;
   
   public class TotemLeftWindowChapterTipView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxtList:Vector.<FilterFrameText>;
      
      private var _titleTxtList:Array;
      
      private var _numTxtList:Array;
      
      private var _propertyTxtList:Array;
      
      public function TotemLeftWindowChapterTipView()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         _titleTxtList = LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.titleListTxt").split(",");
         _numTxtList = LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.numListTxt").split(",");
         _propertyTxtList = LanguageMgr.GetTranslation("ddt.totem.sevenProperty").split(",");
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.totem.chapterTip.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemChapterTip.titleTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemChapterTip.nameTxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_nameTxt);
         _valueTxtList = new Vector.<FilterFrameText>();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("totem.totemChapterTip.valueTxt");
            _loc1_.y = _loc1_.y + _loc2_ * 20;
            addChild(_loc1_);
            _valueTxtList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function show(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1 - 1;
         _titleTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.titleTxt",_numTxtList[_loc3_],_titleTxtList[_loc3_]);
         _nameTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.nameTxt",_numTxtList[_loc3_]);
         var _loc2_:TotemAddInfo = TotemManager.instance.getAddInfo(param1 * 70,(param1 - 1) * 70 + 1);
         _loc4_ = 0;
         while(_loc4_ < 7)
         {
            _valueTxtList[_loc4_].text = _propertyTxtList[_loc4_] + "+" + getAddValue(_loc4_ + 1,_loc2_);
            _loc4_++;
         }
      }
      
      private function getAddValue(param1:int, param2:TotemAddInfo) : int
      {
         var _loc3_:int = 0;
         switch(int(param1) - 1)
         {
            case 0:
               _loc3_ = param2.Attack;
               break;
            case 1:
               _loc3_ = param2.Defence;
               break;
            case 2:
               _loc3_ = param2.Agility;
               break;
            case 3:
               _loc3_ = param2.Luck;
               break;
            case 4:
               _loc3_ = param2.Blood;
               break;
            case 5:
               _loc3_ = param2.Damage;
               break;
            case 6:
               _loc3_ = param2.Guard;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleTxt = null;
         _nameTxt = null;
         _valueTxtList = null;
         _titleTxtList = null;
         _numTxtList = null;
         _propertyTxtList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
