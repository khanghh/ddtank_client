package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import pet.data.PetInfo;
   
   public class PetHappyBar extends Component implements Disposeable
   {
      
      public static const petPercentArray:Array = ["0%","60%","80%","100%"];
      
      public static const fullHappyValue:int = 10000;
       
      
      private var SPACE:int = 2;
      
      private var COUNT:int = 3;
      
      private var _bgImgVec:Vector.<Bitmap>;
      
      private var _heartImgVec:Vector.<Bitmap>;
      
      private var _info:PetInfo;
      
      private var _lv:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      public function PetHappyBar()
      {
         super();
         _bgImgVec = new Vector.<Bitmap>();
         _heartImgVec = new Vector.<Bitmap>();
         initView();
      }
      
      public function get info() : PetInfo
      {
         return _info;
      }
      
      public function set info(value:PetInfo) : void
      {
         _info = value;
         this.tipData = _info;
         happyStatus = !!_info?_info.PetHappyStar:0;
         _lvTxt.text = !!_info?_info.Level.toString():"";
      }
      
      private function gapWidth() : Number
      {
         return _lvTxt.x + 28;
      }
      
      private function initView() : void
      {
         var index:int = 0;
         var img:* = null;
         _lv = ComponentFactory.Instance.creatBitmap("assets.petsBag.Lv");
         addChild(_lv);
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.Lv");
         addChild(_lvTxt);
         for(index = 0; index < COUNT; )
         {
            img = ComponentFactory.Instance.creatBitmap("assets.petsBag.heart1");
            _bgImgVec.push(img);
            addChild(img);
            img.x = gapWidth() + 2 + index * img.width + SPACE;
            index++;
         }
      }
      
      private function set happyStatus(type:int) : void
      {
         if(type > 0)
         {
            if(type > COUNT)
            {
               type = COUNT;
            }
            update(type);
         }
         else
         {
            remove();
         }
      }
      
      private function update(count:int) : void
      {
         var index:int = 0;
         var img:* = null;
         remove();
         for(index = 0; index < count; )
         {
            img = ComponentFactory.Instance.creatBitmap("assets.petsBag.heart2");
            _heartImgVec.push(img);
            addChild(img);
            img.x = gapWidth() + 2 + index * img.width + SPACE;
            index++;
         }
      }
      
      private function remove() : void
      {
         var index:int = 0;
         var count:int = _heartImgVec.length;
         for(index = 0; index < count; )
         {
            ObjectUtils.disposeObject(_heartImgVec[index]);
            index++;
         }
         _heartImgVec.splice(0,_heartImgVec.length);
      }
      
      override public function dispose() : void
      {
         var index:int = 0;
         remove();
         _heartImgVec = null;
         for(index = 0; index < COUNT; )
         {
            ObjectUtils.disposeObject(_bgImgVec[index]);
            index++;
         }
         _bgImgVec.splice(0,_bgImgVec.length);
         _bgImgVec = null;
         if(_lvTxt)
         {
            ObjectUtils.disposeObject(_lvTxt);
            _lvTxt = null;
         }
         if(_lv)
         {
            ObjectUtils.disposeObject(_lv);
            _lv = null;
         }
         super.dispose();
      }
   }
}
