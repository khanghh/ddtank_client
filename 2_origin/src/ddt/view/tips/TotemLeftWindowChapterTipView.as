package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import totem.TotemManager;
   import totem.data.TotemAddInfo;
   import totem.data.TotemChapterTipInfo;
   import totem.data.TotemUpGradDataVo;
   
   public class TotemLeftWindowChapterTipView extends BaseTip implements Disposeable, ITip
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _tipInfo:TotemChapterTipInfo;
      
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
         var i:int = 0;
         var tmp:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.totem.chapterTip.bg");
         _bg.height = 230;
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemChapterTip.titleTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemChapterTip.nameTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemChapterTip.descTxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_nameTxt);
         addChild(_descTxt);
         _valueTxtList = new Vector.<FilterFrameText>();
         for(i = 0; i < 7; )
         {
            tmp = ComponentFactory.Instance.creatComponentByStylename("totem.totemChapterTip.valueTxt");
            tmp.y = tmp.y + i * 20;
            addChild(tmp);
            _valueTxtList.push(tmp);
            i++;
         }
      }
      
      override public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      override public function set tipData(data:Object) : void
      {
         var temValue:int = 0;
         var addValue:int = 0;
         var temStr:* = null;
         var i:int = 0;
         _tipInfo = data as TotemChapterTipInfo;
         if(_tipInfo == null)
         {
            return;
         }
         var chapterIndex:int = _tipInfo.chapterId;
         var tmpIndex:int = chapterIndex - 1;
         var grade:int = _tipInfo.grade;
         var gradeInfo:TotemUpGradDataVo = TotemManager.instance.getUpGradeInfo(chapterIndex,grade);
         var temGrade:int = gradeInfo.grades == 0?0:Number((gradeInfo.grades - 1) % 5 + 1);
         _titleTxt.htmlText = LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.titleTxt",_numTxtList[tmpIndex],gradeInfo.templateName,temGrade);
         _nameTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.nameTxt",_numTxtList[tmpIndex]);
         var maxLev:int = TotemManager.instance.getTotemPointLevel(_tipInfo.totemId);
         maxLev = Math.min(maxLev,chapterIndex * 70);
         var addDataInfo:TotemAddInfo = TotemManager.instance.getAddInfo(maxLev,(chapterIndex - 1) * 70 + 1);
         for(i = 0; i < 7; )
         {
            temValue = getAddValue(i + 1,addDataInfo);
            addValue = gradeInfo.data * temValue / 1000;
            temStr = _propertyTxtList[i] + "+" + temValue;
            if(addValue > 0)
            {
               temStr = temStr + LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.addValue",addValue);
            }
            _valueTxtList[i].htmlText = temStr;
            i++;
         }
         _descTxt.text = LanguageMgr.GetTranslation("ddt.totem.totemChapterTip.descTxt",int(gradeInfo.data / 10));
      }
      
      private function getAddValue(index:int, addDataInfo:TotemAddInfo) : int
      {
         var tmpValue:int = 0;
         switch(int(index) - 1)
         {
            case 0:
               tmpValue = addDataInfo.Attack;
               break;
            case 1:
               tmpValue = addDataInfo.Defence;
               break;
            case 2:
               tmpValue = addDataInfo.Agility;
               break;
            case 3:
               tmpValue = addDataInfo.Luck;
               break;
            case 4:
               tmpValue = addDataInfo.Blood;
               break;
            case 5:
               tmpValue = addDataInfo.Damage;
               break;
            case 6:
               tmpValue = addDataInfo.Guard;
         }
         return tmpValue;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _titleTxt = null;
         _nameTxt = null;
         _valueTxtList = null;
         _titleTxtList = null;
         _numTxtList = null;
         _propertyTxtList = null;
      }
   }
}
