const express = require('express');
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

const app = express();
const port = 3000;

// Middleware to parse JSON
app.use(express.json());

// Serve uploaded images
app.use('/uploads', express.static('uploads'));

// In-memory storage (use database in production)
const otpStore = {};
const users = {
  'user123': {
    id: 'user123',
    name: 'John Doe',
    email: 'user@example.com',
    mobile: '1234567890',
    policyNumber: 'POL-123456789',
    profileImage: null,
  },
};
const claims = [
  {
    id: '1',
    userId: 'user123',
    description: 'Hospital bill for surgery',
    imageUrl: null,
    status: 'approved',
    submittedAt: new Date().toISOString(),
  },
];
const hospitals = [
  {
    id: '1',
    name: 'City General Hospital',
    address: '123 Main Street, Downtown',
    latitude: 12.9716,
    longitude: 77.5946,
    phone: '123-456-7890',
    specialties: ['General Medicine', 'Surgery', 'Emergency'],
  },
  {
    id: '2',
    name: 'Metro Health Center',
    address: '456 Health Ave, Uptown',
    latitude: 12.9816,
    longitude: 77.6046,
    phone: '987-654-3210',
    specialties: ['Cardiology', 'Neurology'],
  },
];

// Basic route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Health Insurance Backend API' });
});

// Login with password
app.post('/login', (req, res) => {
  const { identifier, password } = req.body;
  // Mock authentication
  if ((identifier === 'user@example.com' || identifier === '1234567890' || identifier === 'POL-123456789') && password === 'password') {
    res.json({ success: true, userId: 'user123' });
  } else {
    res.json({ success: false, message: 'Invalid credentials' });
  }
});

// Send OTP
app.post('/send-otp', (req, res) => {
  const { identifier } = req.body;
  const otp = Math.floor(100000 + Math.random() * 900000).toString();
  otpStore[identifier] = otp;
  console.log(`OTP for ${identifier}: ${otp}`); // In real app, send via SMS/email
  res.json({ success: true, message: 'OTP sent successfully' });
});

// Verify OTP
app.post('/verify-otp', (req, res) => {
  const { identifier, otp } = req.body;
  if (otpStore[identifier] === otp) {
    delete otpStore[identifier];
    res.json({ success: true, userId: 'user123' });
  } else {
    res.json({ success: false, message: 'Invalid OTP' });
  }
});

// Get user details
app.get('/users/:id', (req, res) => {
  const user = users[req.params.id];
  if (user) {
    res.json(user);
  } else {
    res.status(404).json({ message: 'User not found' });
  }
});

// Get user's claims
app.get('/claims', (req, res) => {
  const userClaims = claims.filter(claim => claim.userId === req.query.userId);
  res.json(userClaims);
});

// Submit claim with image
app.post('/claims', upload.single('image'), (req, res) => {
  const { userId, description } = req.body;
  const imageUrl = req.file ? `/uploads/${req.file.filename}` : null;
  const newClaim = {
    id: (claims.length + 1).toString(),
    userId,
    description,
    imageUrl,
    status: 'pending',
    submittedAt: new Date().toISOString(),
  };
  claims.push(newClaim);
  res.json({ success: true, message: 'Claim submitted successfully', claim: newClaim });
});

// Get nearby hospitals (mock - in real app, use location-based query)
app.get('/hospitals', (req, res) => {
  // For simplicity, return all hospitals
  res.json(hospitals);
});

// Get coverage info
app.get('/coverage/:userId', (req, res) => {
  res.json({
    coverages: [
      'Hospitalization (up to ₹5,00,000)',
      'Outpatient Care (₹50,000 per year)',
      'Dental Care (₹25,000 per year)',
      'Maternity Care (₹2,00,000)',
      'Emergency Services',
      'Ambulance Services',
      'Prescription Drugs',
      'Preventive Care',
    ],
  });
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});