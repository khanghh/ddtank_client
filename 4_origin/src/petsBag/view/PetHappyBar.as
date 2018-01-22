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
      
      public function set info(param1:PetInfo) : void
      {
         _info = param1;
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
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _lv = ComponentFactory.Instance.creatBitmap("assets.petsBag.Lv");
         addChild(_lv);
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.text.Lv");
         addChild(_lvTxt);
         _loc1_ = 0;
         while(_loc1_ < COUNT)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("assets.petsBag.heart1");
            _bgImgVec.push(_loc2_);
            addChild(_loc2_);
            _loc2_.x = gapWidth() + 2 + _loc1_ * _loc2_.width + SPACE;
            _loc1_++;
         }
      }
      
      private function set happyStatus(param1:int) : void
      {
         if(param1 > 0)
         {
            if(param1 > COUNT)
            {
               param1 = COUNT;
            }
            update(param1);
         }
         else
         {
            remove();
         }
      }
      
      private function update(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         remove();
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("assets.petsBag.heart2");
            _heartImgVec.push(_loc3_);
            addChild(_loc3_);
            _loc3_.x = gapWidth() + 2 + _loc2_ * _loc3_.width + SPACE;
            _loc2_++;
         }
      }
      
      private function remove() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = _heartImgVec.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            ObjectUtils.disposeObject(_heartImgVec[_loc1_]);
            _loc1_++;
         }
         _heartImgVec.splice(0,_heartImgVec.length);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         remove();
         _heartImgVec = null;
         _loc1_ = 0;
         while(_loc1_ < COUNT)
         {
            ObjectUtils.disposeObject(_bgImgVec[_loc1_]);
            _loc1_++;
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
