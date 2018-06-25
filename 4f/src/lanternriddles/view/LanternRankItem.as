package lanternriddles.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.text.TextFormat;   import lanternriddles.data.LanternInfo;   import vip.VipController;      public class LanternRankItem extends Sprite   {                   private var _id:int;            private var _topThreeRank:ScaleFrameImage;            private var _rankNum:FilterFrameText;            private var _vipName:GradientText;            private var _nickName:FilterFrameText;            private var _integral:FilterFrameText;            private var _award:LanternRankItemAward;            private var _info:LanternInfo;            public function LanternRankItem() { super(); }
            private function initView() : void { }
            public function set info(info:LanternInfo) : void { }
            private function addNickName() : void { }
            private function setRankNum(num:int) : void { }
            public function dispose() : void { }
            public function get id() : int { return 0; }
   }}