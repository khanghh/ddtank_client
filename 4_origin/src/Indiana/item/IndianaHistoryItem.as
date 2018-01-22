package Indiana.item
{
   import Indiana.model.HistoryIndianaData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.utils.DateUtils;
   
   public class IndianaHistoryItem extends Sprite implements Disposeable
   {
       
      
      private var _num_txt:GradientBitmapText;
      
      private var _goodName:FilterFrameText;
      
      private var _playName:FilterFrameText;
      
      private var _luckNumTitle:GradientBitmapText;
      
      private var _luckNum:FilterFrameText;
      
      private var _hasTimesTitle:FilterFrameText;
      
      private var _hasTimes:FilterFrameText;
      
      private var _getTime:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _info:HistoryIndianaData;
      
      public function IndianaHistoryItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.scrolltxt.bg");
         _num_txt = ComponentFactory.Instance.creatComponentByStylename("indiana.historyitem.noNum");
         _num_txt.FontSize = 12;
         _goodName = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.Txt");
         PositionUtils.setPos(_goodName,"indiana.historyitem.goodName.pos");
         _playName = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.Txt");
         PositionUtils.setPos(_playName,"indiana.historyitem.playerName.pos");
         _luckNumTitle = ComponentFactory.Instance.creatComponentByStylename("indiana.historyitem.luckNumTitle");
         _num_txt.FontSize = 12;
         _luckNumTitle.setText(LanguageMgr.GetTranslation("Indiana.history.luckCode"));
         _luckNum = ComponentFactory.Instance.creatComponentByStylename("indiana.timesDisII.Txt");
         PositionUtils.setPos(_luckNum,"indiana.historyitem.luckNum.pos");
         _hasTimesTitle = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.Txt");
         _hasTimesTitle.text = LanguageMgr.GetTranslation("Indiana.history.hasTimes");
         PositionUtils.setPos(_hasTimesTitle,"indiana.historyitem.hasTimes.pos");
         _hasTimes = ComponentFactory.Instance.creatComponentByStylename("indiana.timesDisII.Txt");
         PositionUtils.setPos(_hasTimes,"indiana.historyitem.Times.pos");
         _getTime = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.Txt");
         PositionUtils.setPos(_getTime,"indiana.historyitem.getGoodTime.pos");
         addChild(_bg);
         addChild(_num_txt);
         addChild(_goodName);
         addChild(_playName);
         addChild(_hasTimes);
         addChild(_luckNumTitle);
         addChild(_luckNum);
         addChild(_hasTimesTitle);
         addChild(_getTime);
      }
      
      public function setInfo(param1:HistoryIndianaData) : void
      {
         var _loc2_:Number = NaN;
         _info = param1;
         if(_info)
         {
            _num_txt.setText(LanguageMgr.GetTranslation("Indiana.history.perNum",_info.per_name));
            _goodName.text = LanguageMgr.GetTranslation("Indiana.resoult.goods",_info.goodsName);
            _playName.text = LanguageMgr.GetTranslation("Indiana.resoult.nickName",_info.nickName + "(" + _info.areaName + ")");
            _luckNum.text = _info.winningCode.toString();
            _hasTimes.text = LanguageMgr.GetTranslation("Indiana.history.times",_info.joinCount);
            _getTime.text = LanguageMgr.GetTranslation("Indiana.resoult.joinTime",DateUtils.dateFormat5(_info.AnnTime));
            _loc2_ = _num_txt.x + _num_txt.textWidth + 10;
            var _loc3_:* = _loc2_;
            _playName.x = _loc3_;
            _goodName.x = _loc3_;
         }
      }
      
      override public function get width() : Number
      {
         return 42;
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _num_txt = null;
         _goodName = null;
         _playName = null;
         _luckNumTitle = null;
         _luckNum = null;
         _hasTimesTitle = null;
         _getTime = null;
         _hasTimes = null;
      }
   }
}
