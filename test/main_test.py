import unittest
from unittest.mock import MagicMock
import sys
sys.modules['dao'] = MagicMock()
sys.modules['dao.dao'] = MagicMock()

import datetime
from src.main import is2nd4thSaturday

class TestMainFunction(unittest.TestCase):


    def test_is2nd4thSaturday(self):
        self.assertEqual(is2nd4thSaturday(datetime.date(2020,6,12)),False)
        self.assertEqual(is2nd4thSaturday(datetime.date(2020,6,13)),True)
        self.assertEqual(is2nd4thSaturday(datetime.date(2020,6,14)),False)
        self.assertEqual(is2nd4thSaturday(datetime.date(2020,6,27)),True)

        