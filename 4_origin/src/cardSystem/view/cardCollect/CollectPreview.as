package cardSystem.view.cardCollect
{
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.data.SetsPropertyInfo;
   import cardSystem.elements.PreviewCard;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class CollectPreview extends Sprite implements Disposeable
   {
      
      public static const PREVIEWCARD_ALL_LENGTH:int = 350;
      
      public static const PREVIEWCARD_WIDHT:int = 66;
       
      
      private var _bg:MovieImage;
      
      private var _setsName:GradientText;
      
      private var _stroyBG:MovieImage;
      
      private var _flower:Bitmap;
      
      private var _stroy:FilterFrameText;
      
      private var _itemInfo:SetsInfo;
      
      private var _previewCardVec:Vector.<PreviewCard>;
      
      private var _setsPropBG:Bitmap;
      
      private var _propExplain:GradientText;
      
      private var _propDescript:TextArea;
      
      public function CollectPreview()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.BG");
         _setsName = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.setsName");
         _stroyBG = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.BG1");
         _flower = ComponentFactory.Instance.creatBitmap("asset.ddtcardSytems.bg2");
         _stroy = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.story");
         _setsPropBG = ComponentFactory.Instance.creatBitmap("CollectPreview.setsPropBG");
         _propExplain = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.propExplain");
         _propDescript = ComponentFactory.Instance.creatComponentByStylename("CollectPreview.propArea");
         addChild(_bg);
         addChild(_stroyBG);
         addChild(_flower);
         addChild(_stroy);
         addChild(_setsPropBG);
         addChild(_propExplain);
         addChild(_propDescript);
         addChild(_setsName);
         _previewCardVec = new Vector.<PreviewCard>(5);
         for(i = 0; i < 5; )
         {
            _previewCardVec[i] = new PreviewCard();
            addChild(_previewCardVec[i]);
            _previewCardVec[i].y = 148;
            i++;
         }
         _propExplain.text = LanguageMgr.GetTranslation("ddt.cardSystem.preview.propExplain");
      }
      
      public function set info(value:SetsInfo) : void
      {
         if(_itemInfo == value)
         {
            return;
         }
         _itemInfo = value;
         upView();
      }
      
      private function upView() : void
      {
         var i:int = 0;
         var j:int = 0;
         var n:int = 0;
         var m:int = 0;
         var valueArr:* = null;
         var value:* = null;
         var cardInfoVec:Vector.<CardInfo> = CardManager.Instance.model.getSetsCardFromCardBag(_itemInfo.ID);
         _setsName.text = _itemInfo.name;
         _setsName.x = _bg.x + _bg.width / 2 - _setsName.textWidth / 2;
         _stroy.text = "    " + _itemInfo.storyDescript;
         var len:int = _itemInfo.cardIdVec.length;
         for(i = 0; i < 5; )
         {
            if(i < len)
            {
               _previewCardVec[i].cardId = _itemInfo.cardIdVec[i];
               _previewCardVec[i].visible = true;
               if(cardInfoVec.length > 0)
               {
                  for(j = 0; j < cardInfoVec.length; )
                  {
                     if(_previewCardVec[i].cardId == cardInfoVec[j].TemplateID)
                     {
                        _previewCardVec[i].cardInfo = cardInfoVec[j];
                        break;
                     }
                     if(j == cardInfoVec.length - 1)
                     {
                        _previewCardVec[i].cardInfo = null;
                     }
                     j++;
                  }
               }
               else
               {
                  _previewCardVec[i].cardInfo = null;
               }
            }
            else
            {
               _previewCardVec[i].visible = false;
            }
            i++;
         }
         var singleLen:int = 350 / len;
         var lastX:int = 18 + singleLen / 2 - 66 / 2 + 5;
         for(n = 0; n < len; )
         {
            _previewCardVec[n].x = lastX;
            lastX = lastX + (singleLen + 4);
            n++;
         }
         var setsPropVec:Vector.<SetsPropertyInfo> = CardManager.Instance.model.setsList[_itemInfo.ID];
         var len2:int = setsPropVec.length;
         var str:String = "";
         for(m = 0; m < len2; )
         {
            valueArr = setsPropVec[m].value.split("|");
            if(valueArr.length == 4)
            {
               value = valueArr[0] + "/" + valueArr[1] + "/" + valueArr[2] + "/" + valueArr[3] + LanguageMgr.GetTranslation("cardSystem.preview.descript.level");
               str = str.concat(LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp1") + setsPropVec[m].condition + LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp2") + " " + setsPropVec[m].Description.replace("{0}",value));
            }
            else
            {
               str = str.concat(LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp1") + setsPropVec[m].condition + LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp2") + " " + setsPropVec[m].Description.replace("{0}",valueArr[0]));
            }
            str = str.concat("\n\n");
            m++;
         }
         _propDescript.text = str;
         var tf:TextFormat = new TextFormat();
         tf.bold = true;
         var h:int = 0;
         var lastLen:int = 0;
         var string1:String = LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp1");
         var string2:String = LanguageMgr.GetTranslation("ddt.cardSystem.preview.setProp2");
         while(str.indexOf(string1) > -1)
         {
            if(h != 0)
            {
               lastLen = lastLen + (string1.length + string2.length + 1 + str.indexOf(string1));
            }
            _propDescript.textField.setTextFormat(tf,lastLen,lastLen + string1.length + string2.length + 2);
            str = str.substr(str.indexOf(string2) + string2.length + 1,str.length);
            h++;
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         _itemInfo = null;
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _setsName = null;
         _stroyBG = null;
         _stroy = null;
         for(i = 0; i < _previewCardVec.length; )
         {
            _previewCardVec[i] = null;
            i++;
         }
         _previewCardVec = null;
         _setsPropBG = null;
         _propExplain = null;
         _propDescript = null;
         _flower = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
